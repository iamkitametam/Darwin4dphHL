%% prepare
close all; clear all; clc; warning('off','all');
tic;

% profile on;

%% initials

get_parameters;
initialization; initial_state;

%% time loop

for t = 1:Nt

%% pic func optimization

pic_e_x = pic_fast(e_x(1,:),L,Nx);
pic_i_x = pic_fast(i_x(1,:),L,Nx);
pic_e_vx = pic_fast(e_x(1,:),L,Nx,e_vx(1,:));
pic_i_vx = pic_fast(i_x(1,:),L,Nx,i_vx(1,:));
pic_e_vy = pic_fast(e_x(1,:),L,Nx,e_vy(1,:));
pic_i_vy = pic_fast(i_x(1,:),L,Nx,i_vy(1,:));
pic_e_vz = pic_fast(e_x(1,:),L,Nx,e_vz(1,:));
pic_i_vz = pic_fast(i_x(1,:),L,Nx,i_vz(1,:));

%% calc rho and j

% hist()*(1/h) <==> R(r-r')=1/a if (|r-r'|<=h/2)
rho(t,:) = qi*pic_i_x + qe*pic_e_x; 
rho(t,:) = rho(t,:)*Nx/Ne;% normalize n to n0

jx(t,:) = qi*pic_i_vx + qe*pic_e_vx; 
jx(t,:) = jx(t,:)*Nx/Ne;

jy(t,:) = qi*pic_i_vy + qe*pic_e_vy; 
jy(t,:) = jy(t,:)*Nx/Ne;

jz(t,:) = qi*pic_i_vz + qe*pic_e_vz; 
jz(t,:) = jz(t,:)*Nx/Ne;

%% calc scalar potential

% d^2phi/ dx^2 = -rho
phi(t,:) = Thomas(1/h^2*ones(1,Nx),-2/h^2*ones(1,Nx+1),1/h^2*ones(1,Nx),-4*pi*rho(t,:));
% phi(t,:) = phi(t,:)*Nx;

%% calc ex

% e_x = -dphi/dx
% ex(t,:) = calc_ex(-phi(t,:),h,field_bc_flag) + ex_ext(t,:);
ex(t,:) = gradient(-phi(t,:),h);
if(t*tau > t_preprocessing)
ex(t,:) = ex(t,:) + ex_ext(t,:);
end

%% calc mu

mu(t,:) = 4*pi*qi^2/mi*pic_i_x + 4*pi*qe^2/me*pic_e_x;
mu(t,:) = mu(t,:)/Ne;

%% calc phi function

dphi_x(t,:) = jx(t,:);
dphi_y(t,:) = jy(t,:);
dphi_z(t,:) = jz(t,:);

%% calc mean canonical impulse

py(1,:) = mi*(pic_i_vy) + me*pic_e_vy;
py(1,:) = py(1,:)/Ne;

pz(1,:) = mi*(pic_i_vz) + me*pic_e_vz;
pz(1,:) = pz(1,:)/Ne;

if(t>1)
    py(1,:) = py(1,:) + qi*pic_i_x'.*ay(t-1,:)/Ni;
    py(1,:) = py(1,:) + qe*pic_e_x'.*ay(t-1,:)/Ne;
    
    pz(1,:) = pz(1,:) + qi*pic_i_x'.*az(t-1,:)/Ni;
    pz(1,:) = pz(1,:) + qe*pic_e_x'.*az(t-1,:)/Ne;
end

%% calculate fy

fy(t,:) = 4*pi*(qi/mi*pic_i_x + qe/me*pic_e_x)'.*py(1,:)/Ne - dphi_y(t,:);
fz(t,:) = 4*pi*(qi/mi*pic_i_x + qe/me*pic_e_x)'.*pz(1,:)/Ne - dphi_z(t,:);

%% calculate ay az

ay(t,:) = Thomas(1/h^2*ones(1,Nx),-(2/h^2+mu(t,:)),1/h^2*ones(1,Nx),fy(t,:));
az(t,:) = Thomas(1/h^2*ones(1,Nx),-(2/h^2+mu(t,:)),1/h^2*ones(1,Nx),fz(t,:));

%% calculate by bz

% day/dx = bz; daz/dx = by
by(t,:) = calc_ex(-ay(t,:),h,field_bc_flag);
bz(t,:) = calc_ex(-az(t,:),h,field_bc_flag);

if(t*tau > t_preprocessing)
by(t,:) = by(t,:) + by_ext(t,:);
bz(t,:) = bz(t,:) + bz_ext(t,:);
end

if(magn_off)
    ay = zeros(size(ay));
    az = zeros(size(az));
    by = zeros(size(by));
    bz = zeros(size(bz));
end

%% calculate dynamics

% effective fields for electrons
[ex_eff, ay_eff, az_eff, by_eff, bz_eff] = ...
    dynamics(e_x(1,:), ex(t,:), ay(t,:), az(t,:),  by(t,:), bz(t,:), L, Nx);
% VY and VZ for electrons
e_py(2,:) = e_py(1,:) + qe*tau/me*e_vx(1,:).*bz_eff;
e_pz(2,:) = e_pz(1,:) + qe*tau/me*e_vx(1,:).*by_eff;
e_vy(2,:) =  1/me*(e_py(2,:) - qe*ay_eff);
e_vz(2,:) =  1/me*(e_pz(2,:) - qe*az_eff);

% VX and X for electrons
e_vx(2,:) = e_vx(1,:) + qe*tau/me*(ex_eff + (e_vy(2,:).*bz_eff - e_vz(2,:).*by_eff));
e_x(2,:) = e_x(1,:) + tau*e_vx(2,:);
[e_x(2,:), e_vx(2,:)] = bc(e_x(2,:), e_vx(2,:),L,dyn_bc_flag);

% effective fields for ions
[ex_eff, ay_eff, az_eff, by_eff, bz_eff] = ...
    dynamics(i_x(1,:), ex(t,:), ay(t,:), az(t,:), by(t,:), bz(t,:), L, Nx);

% VY and VZ for ions
i_py(2,:) = i_py(1,:) + qi*tau/mi*i_vx(1,:).*bz_eff;
i_pz(2,:) = i_pz(1,:) + qi*tau/mi*i_vx(1,:).*by_eff;
i_vy(2,:) =  1/mi*(i_py(2,:) - qi*ay_eff);
i_vz(2,:) =  1/mi*(i_pz(2,:) - qi*az_eff);

% VX and X for ions
i_vx(2,:) = i_vx(1,:) + qi*tau/mi*(ex_eff + (i_vy(2,:).*bz_eff - i_vz(2,:).*by_eff));
i_x(2,:) = i_x(1,:) + tau*i_vx(2,:);
[i_x(2,:), i_vx(2,:)] = bc(i_x(2,:), i_vx(2,:),L,dyn_bc_flag);

%% duty ratio and loop ending

if(mod(t,Q)==0)
    
    total_electrons_x(t/Q,:) = e_x(2,P:P:Ne);
    total_electrons_vx(t/Q,:) = e_vx(2,P:P:Ne);
    total_electrons_vy(t/Q,:) = e_vy(2,P:P:Ne);
    total_electrons_vz(t/Q,:) = e_vz(2,P:P:Ne);
    
    total_ions_x(t/Q,:) = i_x(2,P:P:Ni);
    total_ions_vx(t/Q,:) = i_vx(2,P:P:Ni);
    total_ions_vy(t/Q,:) = i_vy(2,P:P:Ni);
    total_ions_vz(t/Q,:) = i_vz(2,P:P:Ni);
     
end

e_x(1,:) = e_x(2,:);
e_vx(1,:) = e_vx(2,:);
e_vy(1,:) = e_vy(2,:);
e_vz(1,:) = e_vz(2,:);
e_py(1,:) = e_py(2,:);
e_pz(1,:) = e_pz(2,:);


i_x(1,:) = i_x(2,:);
i_vx(1,:) = i_vx(2,:);
i_vy(1,:) = i_vy(2,:);
i_vz(1,:) = i_vz(2,:);
i_py(1,:) = i_py(2,:);
i_pz(1,:) = i_pz(2,:);

%% calculation parameters

if(mod(t,Nt/100)==0)
clc;
fprintf('Completed: %d%% t = %.1f of %.0f \n',round(t/Nt*100),t*tau,T);
end

end

toc;

% profsave;

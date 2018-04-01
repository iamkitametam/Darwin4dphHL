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

pic_e_x = pic_fast(e_x(t,:),L,Nx);
pic_i_x = pic_fast(i_x(t,:),L,Nx);
pic_e_vx = pic_fast(e_x(t,:),L,Nx,e_vx(t,:));
pic_i_vx = pic_fast(i_x(t,:),L,Nx,i_vx(t,:));
pic_e_vy = pic_fast(e_x(t,:),L,Nx,e_vy(t,:));
pic_i_vy = pic_fast(i_x(t,:),L,Nx,i_vy(t,:));
pic_e_vz = pic_fast(e_x(t,:),L,Nx,e_vz(t,:));
pic_i_vz = pic_fast(i_x(t,:),L,Nx,i_vz(t,:));

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

py(t,:) = mi*(pic_i_vy) + me*pic_e_vy;
py(t,:) = py(t,:)/Ne;

pz(t,:) = mi*(pic_i_vz) + me*pic_e_vz;
pz(t,:) = pz(t,:)/Ne;

if(t>1)
    py(t,:) = py(t,:) + qi*pic_i_x'.*ay(t-1,:)/Ni;
    py(t,:) = py(t,:) + qe*pic_e_x'.*ay(t-1,:)/Ne;
    
    pz(t,:) = pz(t,:) + qi*pic_i_x'.*az(t-1,:)/Ni;
    pz(t,:) = pz(t,:) + qe*pic_e_x'.*az(t-1,:)/Ne;
end

%% calculate fy

fy(t,:) = 4*pi*(qi/mi*pic_i_x + qe/me*pic_e_x)'.*py(t,:)/Ne - dphi_y(t,:);
fz(t,:) = 4*pi*(qi/mi*pic_i_x + qe/me*pic_e_x)'.*pz(t,:)/Ne - dphi_z(t,:);

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
    dynamics(e_x(t,:), ex(t,:), ay(t,:), az(t,:),  by(t,:), bz(t,:), L, Nx);
% VY and VZ for electrons
e_py(t+1,:) = e_py(t,:) + qe*tau/me*e_vx(t,:).*bz_eff;
e_pz(t+1,:) = e_pz(t,:) + qe*tau/me*e_vx(t,:).*by_eff;
e_vy(t+1,:) =  1/me*(e_py(t+1,:) - qe*ay_eff);
e_vz(t+1,:) =  1/me*(e_pz(t+1,:) - qe*az_eff);

% VX and X for electrons
e_vx(t+1,:) = e_vx(t,:) + qe*tau/me*(ex_eff + (e_vy(t+1,:).*bz_eff - e_vz(t+1,:).*by_eff));
e_x(t+1,:) = e_x(t,:) + tau*e_vx(t+1,:);
[e_x(t+1,:), e_vx(t+1,:)] = bc(e_x(t+1,:), e_vx(t+1,:),L,dyn_bc_flag);

% effective fields for ions
[ex_eff, ay_eff, az_eff, by_eff, bz_eff] = ...
    dynamics(i_x(t,:), ex(t,:), ay(t,:), az(t,:), by(t,:), bz(t,:), L, Nx);

% VY and VZ for ions
i_py(t+1,:) = i_py(t,:) + qi*tau/mi*i_vx(t,:).*bz_eff;
i_pz(t+1,:) = i_pz(t,:) + qi*tau/mi*i_vx(t,:).*by_eff;
i_vy(t+1,:) =  1/mi*(i_py(t+1,:) - qi*ay_eff);
i_vz(t+1,:) =  1/mi*(i_pz(t+1,:) - qi*az_eff);

% VX and X for ions
i_vx(t+1,:) = i_vx(t,:) + qi*tau/mi*(ex_eff + (i_vy(t+1,:).*bz_eff - i_vz(t+1,:).*by_eff));
i_x(t+1,:) = i_x(t,:) + tau*i_vx(t+1,:);
[i_x(t+1,:), i_vx(t+1,:)] = bc(i_x(t+1,:), i_vx(t+1,:),L,dyn_bc_flag);

%% calculation parameters

if(mod(t,Nt/100)==0)
clc;
fprintf('Completed: %d%% t = %.1f of %.0f \n',round(t/Nt*100),t*tau,T);
end

end

toc;

% profsave;

%% calculate integral characteristics

%% kinetic

kin_e_x = zeros(Nt,1); kin_e_y = zeros(Nt,1); kin_e_z = zeros(Nt,1);
kin_i_x = zeros(Nt,1); kin_i_y = zeros(Nt,1); kin_i_z = zeros(Nt,1);

imp_e_x = zeros(Nt,1); imp_e_y = zeros(Nt,1); imp_e_z = zeros(Nt,1);
imp_i_x = zeros(Nt,1); imp_i_y = zeros(Nt,1); imp_i_z = zeros(Nt,1);

for i=1:Nt
    kin_e_x(i) = me*sum(e_vx(i,:).^2); kin_e_y(i) = me*sum(e_vy(i,:).^2); kin_e_z(i) = me*sum(e_vz(i,:).^2);
    kin_i_x(i) = mi*sum(i_vx(i,:).^2); kin_i_y(i) = mi*sum(i_vy(i,:).^2); kin_i_z(i) = mi*sum(i_vz(i,:).^2);
    
    imp_e_x(i) = me*sum(e_vx(i,:)); imp_e_y(i) = me*sum(e_vy(i,:)); imp_e_z(i) = me*sum(e_vz(i,:));
    imp_i_x(i) = mi*sum(i_vx(i,:)); imp_i_y(i) = mi*sum(i_vy(i,:)); imp_i_z(i) = mi*sum(i_vz(i,:));
end
kin_e_x = kin_e_x/(Ne); kin_e_y = kin_e_y/(Ne); kin_e_z = kin_e_z/(Ne);
kin_i_x = kin_i_x/(Ni); kin_i_y = kin_i_y/(Ni); kin_i_z = kin_i_z/(Ni);

imp_e_x = imp_e_x/(Ne); imp_e_y = imp_e_y/(Ne); imp_e_z = imp_e_z/(Ne);
imp_i_x = imp_i_x/(Ni); imp_i_y = imp_i_y/(Ni); imp_i_z = imp_i_z/(Ni);

%% field

ex_energy = zeros(Nt,1); by_energy = zeros(Nt,1); bz_energy = zeros(Nt,1);

for i=1:Nt
    ex_energy(i) = sum(ex(i,:).^2/2);
    by_energy(i) = sum(by(i,:).^2/2);
    bz_energy(i) = sum(bz(i,:).^2/2);
end

ex_energy = ex_energy/Nx;
by_energy = by_energy/Nx;
bz_energy = bz_energy/Nx;

%% plotting

figure('Name','DYNAMICS INTEGRAL CHARACTERISTICS'); plotbrowser('on');

sp(1) = subplot(4,3,1);
plot(tau:tau:T,kin_e_x);
grid on; grid minor;
title('electron E^{kin}_x, [n_0mc^2]');

sp(2) = subplot(4,3,2);
plot(tau:tau:T,kin_e_y);
grid on; grid minor;
title('electron E^{kin}_y, [n_0mc^2]');

sp(3) = subplot(4,3,3);
plot(tau:tau:T,kin_e_z);
grid on; grid minor;
title('electron E^{kin}_z, [n_0mc^2]');

sp(4) = subplot(4,3,4);
plot(tau:tau:T,kin_i_x);
grid on; grid minor;
title('ion E^{kin}_x, [n_0mc^2]');

sp(5) = subplot(4,3,5);
plot(tau:tau:T,kin_i_y);
grid on; grid minor;
title('ion E^{kin}_y, [n_0mc^2]');

sp(6) = subplot(4,3,6);
plot(tau:tau:T,kin_i_z);
grid on; grid minor;
title('ion E^{kin}_z, [n_0mc^2]');

sp(7) = subplot(4,3,7);
plot(tau:tau:T,imp_e_x);
grid on; grid minor;
title('electron P_x, [n_0mc]');

sp(8) = subplot(4,3,8);
plot(tau:tau:T,imp_e_y);
grid on; grid minor;
title('electron P_y, [n_0mc]');

sp(9) = subplot(4,3,9);
plot(tau:tau:T,imp_e_z);
grid on; grid minor;
title('electron P_z, [n_0mc]');

sp(10) = subplot(4,3,10);
plot(tau:tau:T,imp_i_x);
grid on; grid minor;
title('ion P_x, [n_0mc]');

sp(11) = subplot(4,3,11);
plot(tau:tau:T,imp_i_y);
grid on; grid minor;
title('ion P_y, [n_0mc]');

sp(12) = subplot(4,3,12);
plot(tau:tau:T,imp_i_z);
grid on; grid minor;
title('ion P_z, [n_0mc]');

linkaxes(sp,'x');

% FIELD INTEGRAL CHARACTERISTICS

figure('Name','FIELD INTEGRAL CHARACTERISTICS'); plotbrowser('on');

sp1(1) = subplot(3,1,1);
plot(tau:tau:T,ex_energy);
grid on; grid minor;
title('E_x energy, [n_0mc^2]');

sp1(2) = subplot(3,1,2);
plot(tau:tau:T,by_energy);
grid on; grid minor;
title('B_y energy, [n_0mc^2]');

sp1(3) = subplot(3,1,3);
plot(tau:tau:T,bz_energy);
grid on; grid minor;
title('B_z energy, [n_0mc^2]');

linkaxes(sp1,'x');

% TOTAL

figure('Name','TOTAL INTEGRAL CHARACTERISTICS'); plotbrowser('on');

kin_total = kin_e_x + kin_e_y + kin_e_z + kin_i_x + kin_i_y + kin_i_z ;
imp_total = imp_e_x + imp_e_y + imp_e_z + imp_i_x + imp_i_y + imp_i_z;
elmag_energy = ex_energy + by_energy + bz_energy;

sp2(1) = subplot(4,1,1);
plot(tau:tau:T, kin_total);
grid on; grid minor;
title('kinetic energy total, [n_0mc^2]');

sp2(2) = subplot(4,1,2);
plot(tau:tau:T, imp_total);
grid on; grid minor;
title('impulse total, [n_0mc]');

sp2(3) = subplot(4,1,3);
plot(tau:tau:T,elmag_energy);
grid on; grid minor;
title('electromagnetic energy, [n_0mc^2]');

sp2(4) = subplot(4,1,4);
plot(tau:tau:T, kin_total + elmag_energy);
grid on; grid minor;
title('energy total, [n_0mc^2]');

linkaxes(sp2,'x');

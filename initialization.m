%% phase coordinates

i_x = zeros(2,Ni); e_x = zeros(2,Ne);
i_vx = zeros(2,Ni); e_vx = zeros(2,Ne);
i_vy = zeros(2,Ni); e_vy = zeros(2,Ne); e_py = zeros(2,Ne); e_pz = zeros(2,Ne);
i_vz = zeros(2,Ni); e_vz = zeros(2,Ne); i_py = zeros(2,Ni); i_pz = zeros(2,Ni);

%% nodes

rho = zeros(Nt,Nx+1); jx = zeros(Nt,Nx+1); jy = zeros(Nt,Nx+1); jz = zeros(Nt,Nx+1);
phi = zeros(Nt,Nx+1); ay = zeros(Nt,Nx+1); az = zeros(Nt,Nx+1);
ex = zeros(Nt,Nx+1); by = zeros(Nt,Nx+1); bz = zeros(Nt,Nx+1);
py = zeros(Nt,Nx+1); pz = zeros(Nt,Nx+1);
dphi_x = zeros(Nt,Nx+1); dphi_y = zeros(Nt,Nx+1); dphi_z = zeros(Nt,Nx+1);
mu = zeros(Nt,Nx+1); fy = zeros(Nt,Nx+1); fz = zeros(Nt,Nx+1);

%% results

total_ions_x = zeros(Nt/Q,Ni/P); total_ions_vx = zeros(Nt/Q,Ni/P);
total_ions_vy = zeros(Nt/Q,Ni/P); total_ions_vz = zeros(Nt/Q,Ni/P);
total_electrons_x = zeros(Nt/Q,Ni/P); total_electrons_vx = zeros(Nt/Q,Ni/P);
total_electrons_vy = zeros(Nt/Q,Ni/P); total_electrons_vz = zeros(Nt/Q,Ni/P);
total_rho = zeros(Nt/Q,Nx+1); total_jx = zeros(Nt/Q,Nx+1);
total_jy = zeros(Nt/Q,Nx+1); total_jz = zeros(Nt/Q,Nx+1);
total_phi = zeros(Nt/Q,Nx+1); total_ay = zeros(Nt/Q,Nx+1); total_az = zeros(Nt/Q,Nx+1); 
total_ex = zeros(Nt/Q,Nx+1); total_by = zeros(Nt/Q,Nx+1); total_bz = zeros(Nt/Q,Nx+1);
total_py = zeros(Nt/Q,Nx+1); total_pz = zeros(Nt/Q,Nx+1);
total_dphi_x = zeros(Nt/Q,Nx+1); total_dphi_y = zeros(Nt/Q,Nx+1); total_dphi_z = zeros(Nt/Q,Nx+1); 
total_mu = zeros(Nt/Q,Nx+1); total_fy = zeros(Nt/Q,Nx+1); total_fz = zeros(Nt/Q,Nx+1);

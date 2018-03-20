%% meshes 
T = 10; Nt = 1000; tau = T/Nt;
L = 2.5; Nx = 50; h = L/Nx;
t_preprocessing = 0;

%% particles
Ne = 10^4; me = 1; qe = -1; ve = 0.1; Te = 1;
Ni = Ne; mi = 400; qi = 1; vi = ve/sqrt(mi*Te); n0  = Ni/L;

%% external fields
pivchik
ex_ext = zeros(Nt,Nx+1); by_ext = zeros(Nt,Nx+1); bz_ext = zeros(Nt,Nx+1);
for i=1:Nt
%     ex_ext(i,:) = 0.0316*sin(200*pi*i/Nt);
%     bz_ext(i,:) = 0.4*sin(2*pi*(1:Nx+1)/(Nx+1));
end

%% turn magn field off = 1, on = 0

magn_off = 0;

%% border conditions
field_bc_flag = 2;% 1 - Dirichlet, 2 - Neumann
dyn_bc_flag = 2;% 1 - reflect, 2 - periodical

%% calculation parameters
P = 1; Q = 1;% duty ratio P-particles Q-time

%% initial phase coordinates distribution

random = 1;
twostream = 0;
weibel = 0;

%% experiment parameters

experiment_name = 'Test1';

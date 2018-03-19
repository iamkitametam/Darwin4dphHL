function [ex_eff, ay_eff, az_eff, by_eff, bz_eff] = dynamics(e_x, ex, ay, az, by, bz, L, Nx)

% Ne = size(e_x,2);
% 
% ex_eff = zeros(1,Ne);
% ay_eff = zeros(1,Ne);
% az_eff = zeros(1,Ne);
% by_eff = zeros(1,Ne);
% bz_eff = zeros(1,Ne);
% by_ext_eff = zeros(1,Ne);
% bz_ext_eff = zeros(1,Ne);
% 
% for i=1:Ne
%     [np1, np2, h1, h2] = getnearest(L,Nx,e_x(i));
%     ex_eff(i) = ex(np1)*(1-h1) + ex(np2)*(1-h2);
%     ay_eff(i) = ay(np1)*(1-h1) + ay(np2)*(1-h2);
%     az_eff(i) = az(np1)*(1-h1) + az(np2)*(1-h2);
%     by_eff(i) = by(np1)*(1-h1) + by(np2)*(1-h2);
%     bz_eff(i) = by(np1)*(1-h1) + bz(np2)*(1-h2);
%     by_ext_eff(i) = by_ext(np1)*(1-h1) + by_ext(np2)*(1-h2);
%     bz_ext_eff(i) = bz_ext(np1)*(1-h1) + bz_ext(np2)*(1-h2);
% end

h = L/Nx;
[np1, np2, h1, h2] = getnearest(L,Nx,e_x);
h1 = h1/h; h2 = h2/h;

ex_eff = ex(np1).*(1-h1) + ex(np2).*(1-h2);
ay_eff = ay(np1).*(1-h1) + ay(np2).*(1-h2);
az_eff = az(np1).*(1-h1) + az(np2).*(1-h2);
by_eff = by(np1).*(1-h1) + by(np2).*(1-h2);
bz_eff = by(np1).*(1-h1) + bz(np2).*(1-h2);
% by_ext_eff = by_ext(np1).*(1-h1) + by_ext(np2).*(1-h2);
% bz_ext_eff = bz_ext(np1).*(1-h1) + bz_ext(np2).*(1-h2);

end
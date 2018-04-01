function [ex_eff, ay_eff, az_eff, by_eff, bz_eff] = dynamics(e_x, ex, ay, az, by, bz, L, Nx)

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

function [np1, np2, h1, h2] = getnearest(L,Nx,xx)

Ni = max(size(xx));
h = L/Nx;
x = 0:h:L;

qq = zeros(Nx+1,Ni);
for i=1:Nx+1
    qq(i,:) = xx - x(i);
end

np2 = sum(qq>0)+1;
np1 = np2-1;

h1 = xx - x(np1);
h2 = x(np2) - xx;

end


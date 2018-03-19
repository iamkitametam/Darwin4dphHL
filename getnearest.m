% function [np1, np2, h1, h2] = getnearest(L,Nx,xx)
%     h = L/Nx;
%     x = 0:h:L;
%     q = abs(bsxfun(@minus,x,xx));
%     q_s = sort(q);
%     np1 = find(q==q_s(1));
%     np2 = find(q==q_s(2));
%     h1 = abs(xx-x(np1))/h;
%     h2 = abs(xx-x(np2))/h;
% end

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


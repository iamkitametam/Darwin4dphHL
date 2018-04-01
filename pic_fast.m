%% function
function answer = pic_fast(x,L,Nx,v)

h = L/Nx; grid_x = 0:h:L;
dx = abs(minus(x,grid_x'));
[r, ~] = find(dx==min(dx));

switch nargin
    case 3
        bins = 1:Nx+1;
        answer = hist(r,bins)';
    case 4
        answer = zeros(Nx+1,1);
        for i=1:Nx+1
            answer(i) = sum(v(r==i));
        end
end
end
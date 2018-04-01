L = 2;
Nx = 10;
Ni = 10;
x = L*rand(1,Ni);
v = 0.1*rand(1,Ni);


f = 4;
switch f
    case 3
        tic;
        q = pic_fast(x,L,Nx);
        toc;
        tic;
        h = L/Nx; grid_x = 0:h:L;
        dx = abs(minus(x,grid_x'));
        [r, ~] = find(dx==min(dx));
        bins = 1:Nx+1;
        answer = hist(r,bins)';
        toc;
    case 4
        tic;
        q = pic_fast(x,L,Nx,v);
        toc;
        tic;
        h = L/Nx; grid_x = 0:h:L;
        dx = abs(minus(x,grid_x'));
        [r, ~] = find(dx==min(dx));
        answer = zeros(Nx+1,1);
        for i=1:Nx+1
            answer(i) = sum(v(r==i));
        end
        toc;
end


z = logical([0 1 1 0;
    1 0 0 0;
    1 1 0 0;
    0 0 0 1]);

zz=  magic(4);



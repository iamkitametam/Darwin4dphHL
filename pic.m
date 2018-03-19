function answer = pic(x,L,Nx,v)
    
answer = zeros(Nx+1,1);
h = L/Nx; N_part = size(x,2);
    
switch nargin
        
    case 3
        for i=1:N_part
            dx = (0:h:L) - x(i)*ones(1,Nx+1);
            np = find(abs(dx)<=h/2);
            answer(np) = answer(np)+1;
        end
    case 4
        for i=1:N_part
            dx = (0:h:L) - x(i)*ones(1,Nx+1);
            np = find(abs(dx)<=h/2);
            answer(np) = answer(np)+v(i);
        end     
    otherwise 
        disp('ERROR: WRONG INPUT IN PIC');
        return

end
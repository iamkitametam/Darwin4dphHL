% function answer = pic_fast(x,L,Nx,v)

%% head
% Nx = 10; Np = 10;
% L = 1;
% x = rand(1,Np)*L;
% vx = rand(1,Np)/10;

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
% toc;
% tic;
% answer_pic = pic(x,L,Nx);
% answer_pic_vx = pic(x,L,Nx,vx);
% toc;
end
% disp(answer);
% disp(answer_pic');
% disp('__________________________');
% disp(answer_vx');
% disp(answer_pic_vx');

% switch nargin
% 
%     case 3
%         
%     case 4
%         
% end

% end

%% pic

% function answer = pic(x,L,Nx,v)
%     
% answer = zeros(Nx+1,1);
% h = L/Nx; N_part = size(x,2);
%     
% switch nargin
%         
%     case 3
%         for i=1:N_part
%             dx = (0:h:L) - x(i)*ones(1,Nx+1);
%             np = find(abs(dx)<=h/2);
%             answer(np) = answer(np)+1;
%         end
%     case 4
%         for i=1:N_part
%             dx = (0:h:L) - x(i)*ones(1,Nx+1);
%             np = find(abs(dx)<=h/2);
%             answer(np) = answer(np)+v(i);
%         end     
%     otherwise 
%         disp('ERROR: WRONG INPUT IN PIC');
%         return
% 
% end
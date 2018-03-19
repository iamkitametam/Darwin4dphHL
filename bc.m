function [x, vx] = bc(x,vx,L,dyn_bc_flag)

switch dyn_bc_flag
    
    case 1
        
        while(sum(x<-L))
            ind = find(x<-L);
            x(ind) = x(ind) + L;
        end
        while(sum(x>2*L))
            ind = find(x>2*L);
            x(ind) = x(ind) - L;
        end
            ind = find(x<0);
            x(ind) = -x(ind);
            vx(ind) = -vx(ind);
            ind = find(x>L);
            x(ind) = 2*L - x(ind);
            vx(ind) = -vx(ind);
            
    case 2
        
        while(sum(x<0)~=0)
            indices_less = find(x<0);
            x(indices_less) = x(indices_less) + L;
        end
        while(sum(x>L)~=0)
            indices_less = find(x>L);
            x(indices_less) = x(indices_less) - L;
        end
        
    otherwise
        
        disp('this bc flag not considered');
end
                

function ex = calc_ex(phi,h,field_bc_flag)

sz = size(phi,2);
ex = zeros(1,sz);

switch field_bc_flag
    case 1
%         fin_diff = diff(phi)*h;
%         ex(2:end-1) = fin_diff(1:end-1);
        for i=2:sz-1
            ex(i) = (phi(i+1) - phi(i-1))/(2*h);
        end
        ex(1) = 0;
        ex(end) = 0;
    case 2
%         fin_diff = diff(phi)*h;
%         ex(2:end-1) = fin_diff(1:end-1);
        for i=2:sz-1
            ex(i) = (phi(i+1) - phi(i-1))/(2*h);
        end
        ex(1) = ex(2);
        ex(end) = ex(end-1);
    otherwise
        disp('FIELD BORDER CONDITION FLAG ERROR');
        return
end

end
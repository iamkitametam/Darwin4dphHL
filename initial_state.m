%% RANDOM STATE

if(random)
    % ions
    i_x(1,:) = rand(1,Ni)*L;
    i_vx(1,:) = vi*randn(1,Ni);
    i_vy(1,:) = vi*randn(1,Ni);
    i_vz(1,:) = vi*randn(1,Ni);
    i_py(1,:) = mi*i_vy(1,:);
    i_pz(1,:) = mi*i_vz(1,:);

    % electrons
    e_x(1,:) = rand(1,Ne)*L;
    e_vx(1,:) = ve*randn(1,Ne);
    e_vy(1,:) = ve*randn(1,Ne);
    e_vz(1,:) = ve*randn(1,Ne);
    e_py(1,:) = me*e_vy(1,:);
    e_pz(1,:) = me*e_vz(1,:);
end

%% twostream instability STATE

if(twostream)
    % ions
    i_x(1,:) = rand(1,Ni)*L;
    i_vx(1,:) = vi*randn(1,Ni);
    i_vy(1,:) = vi*randn(1,Ni);
    i_vz(1,:) = vi*randn(1,Ni);
    i_py(1,:) = mi*i_vy(1,:);
    i_pz(1,:) = mi*i_vz(1,:);

    % electrons
    e_x(1,:) = rand(1,Ne)*L;
    e_vx(1,:) = ve*randn(1,Ne);
    e_vy(1,:) = ve*randn(1,Ne);
    e_vz(1,:) = ve*randn(1,Ne);
    e_py(1,:) = me*e_vy(1,:);
    e_pz(1,:) = me*e_vz(1,:);
    
    e_vx(1,1:Ne/2) = abs(e_vx(1,1:Ne/2)) + 3*ve;
end

%% Weibel instability STATE

if(weibel)
   
    A0 = 24;
    
    % ions
    i_x(1,:) = rand(1,Ni)*L;
    i_vx(1,:) = vi*randn(1,Ni);
    i_vy(1,:) = vi*randn(1,Ni);
    i_vz(1,:) = vi*randn(1,Ni);
    i_py(1,:) = mi*i_vy(1,:);
    i_pz(1,:) = mi*i_vz(1,:);

    % electrons
    e_x(1,:) = rand(1,Ne)*L;
    e_vx(1,:) = ve*randn(1,Ne);
    e_vy(1,:) = ve*randn(1,Ne);
    e_vz(1,:) = sqrt(A0+1)*ve*randn(1,Ne);
    e_py(1,:) = me*e_vy(1,:);
    e_pz(1,:) = me*e_vz(1,:);
    
end

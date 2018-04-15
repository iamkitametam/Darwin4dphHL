x_flag = 0;
total_electrons_vx_flag = 1;
field_flag = 0;
phase_flag = 0;

%% hist

if(x_flag)
    figure('units','normalized','outerposition',[.0 .0 1 1]);
    for i=1:Nt/Q/Q
        clf;
        subplot(2,1,1);
        hist(total_electrons_x(i,:),100);
        ylim([0 10*Ni/100]);
        grid on; grid minor;
        title(strcat('electron x',32, num2str(tau*i*Q),'/',num2str(T)));
        
        subplot(2,1,2);
        hist(total_ions_x(i,:),100);
        ylim([0 10*Ni/100]);
        grid on; grid minor;
        title(strcat('ion x',32, num2str(tau*i*Q),'/',num2str(T)));
        
        pause(1/(Nt/Q));
    end
end

if(total_electrons_vx_flag)
    
figure('units','normalized','outerposition',[.0 .0 1 1]);
for i=1:Nt/Q
   hist(total_electrons_vx(i,:),100);
   xlim([-10*ve 10*ve]);
   ylim([0 Ne/100*10])
   grid on; grid minor;
   title(num2str(i*tau*Q));
   pause(1/(Nt/Q));
end

end

%% phase plane

if(phase_flag)
    figure('Name','Phase Plane','units','normalized','outerposition',[.0 .0 1 1]);
    clf;
    for i=1:Nt/Q
       
       subplot(2,2,1);
       plot(total_electrons_x(i,:),total_electrons_vx(i,:),'.');
       grid on; grid minor;
       xlabel('x');
       ylabel('vx');
       xlim([0 L]);
       ylim([-10*ve 10*ve]);
       title("Electron vx " + num2str(i*tau*Q));
       
       subplot(2,2,2);
       plot(total_ions_x(i,:),total_ions_vx(i,:),'.');
       grid on; grid minor;
       xlabel('x');
       ylabel('vx');
       xlim([0 L]);
       ylim([-10*vi 10*vi]);
       title("Ion vx " + num2str(i*tau*Q));
       
       subplot(2,2,3);
       plot(total_electrons_x(i,:),total_electrons_vy(i,:),'.');
       grid on; grid minor;
       xlabel('x');
       ylabel('vx');
       xlim([0 L]);
       ylim([-10*ve 10*ve]);
       title("Electron vy " + num2str(i*tau*Q));
       
       subplot(2,2,4);
       plot(total_ions_x(i,:),total_ions_vy(i,:),'.');
       grid on; grid minor;
       xlabel('x');
       ylabel('vx');
       xlim([0 L]);
       ylim([-10*vi 10*vi]);
       title("Ion vy " + num2str(i*tau*Q));
       
       pause(1/(Nt/Q));
    end
end

%% plotting

if(field_flag)
    
    figure('Name','RHO, J');
    plotbrowser('on');

    subplot(2,2,1);
    plot(0:h:L,rho(t,:)); grid on; grid minor; title('rho');

    subplot(2,2,2);
    plot(0:h:L,jx(t,:)); grid on; grid minor; title('j_x');
    subplot(2,2,3);
    plot(0:h:L,jy(t,:)); grid on; grid minor; title('j_y');
    subplot(2,2,4);
    plot(0:h:L,jz(t,:)); grid on; grid minor; title('j_z'); 

    figure('Name','PHI, A');
    plotbrowser('on');

    subplot(3,3,1);
    plot(0:h:L,phi(t,:)); grid on; grid minor; title('phi');

    subplot(3,3,2);
    plot(0:h:L,mu(t,:)); grid on; grid minor; title('\mu');

    subplot(3,3,3);
    plot(0:h:L,py(t,:)); grid on; grid minor; title('p_y');

    subplot(3,3,4);
    plot(0:h:L,pz(t,:)); grid on; grid minor; title('p_z');

    subplot(3,3,5);
    plot(0:h:L,fy(t,:)); grid on; grid minor; title('f_y');

    subplot(3,3,6);
    plot(0:h:L,fz(t,:)); grid on; grid minor; title('f_z');

    subplot(3,3,7);
    plot(0:h:L,ay(t,:)); grid on; grid minor; title('a_y');

    subplot(3,3,8);
    plot(0:h:L,az(t,:)); grid on; grid minor; title('a_z');

    figure('Name','FIELDS');
    plotbrowser('on');

    subplot(2,2,1);
    plot(0:h:L,ex(t,:)); grid on; grid minor; title('E_x');

    subplot(2,2,2);
    plot(0:h:L,by(t,:)); grid on; grid minor; title('b_y');

    subplot(2,2,3);
    plot(0:h:L,bz(t,:)); grid on; grid minor; title('b_z');

end
function results = analyse(sln, parameters, to_plot_all, to_plot_NO, to_plot_gait)

t = []; y = []; gait_len = []; gait_freq = [];
for i = 1:length(sln.T)
    t = [t; sln.T{i}];
    y = [y; sln.Y{i}];  % corresponds to q1,q2,q3,dq1,dq2,dq3
    gait_freq(i) = sln.T{i}(end)-sln.T{i}(1) ;
    [~,gait_len(i),~,~] = kin_hip(sln.Y{i}(end,1:3)-sln.Y{i}(1,1:3),sln.Y{i}(end,4:6)-sln.Y{i}(1,4:6)) ;
end
te = sln.TE{end};
ye = sln.YE{end};

% calculate gait quality metrics (distance, step frequency, step length,
% velocity, etc.)

[x_h, z_h, dx_h, dz_h] = kin_hip(y(:,1:3), y(:,4:6));

% that means optimization doesn't need us to compute explicit u to optimize
% it
u = zeros(length(t),2);
for i = 1:length(t)
    u(i,:) = control(t(i), y(i,1:3), y(i,4:6), y(1,1:3), y(1,4:6), 0, parameters);
end

save('g','u');

dist = x_h(end);
sp_max = max(dx_h);
sp_min = min(dx_h);
effort = 1./(2*length(u(:,1))*30)*(u(:,1)'*u(:,1)+u(:,2)'*u(:,2));
CoT = effort/(x_h(end)-x_h(1));
sp_mean = mean(abs(dx_h));
hip_min = min(z_h);
hip_start = z_h(1);


results = [dist,sp_max, sp_mean, sp_min, mean(gait_len), CoT, hip_min, hip_start, std(gait_len), 1/mean(gait_freq)];

% calculate actuation (you can use the control function)

if to_plot_all
    
    figure('Name','Gait quality measures','Numbertitle','off')
    
    % plot the angles
    subplot(5,4,9)
    plot(y(:,1),y(:,4));
    title('Angle q1 vs its derivative')
    xlabel('q1');
    ylabel('dq1');
    
    subplot(5,4,10)
    plot(y(:,2),y(:,5));
    title('Angle q2 vs its derivative')
    xlabel('q2');
    ylabel('dq2');
    
    subplot(5,4,13)
    plot(y(:,3),y(:,6));
    title('Angle q3 vs its derivative')
    xlabel('q3');
    ylabel('dq3');
    
    
    subplot(5,4,14)
    plot(t,y(:,1));
    title('Angle q1 vs time')
    ylabel('q1');
    xlabel('t');
    
    subplot(5,4,17)
    plot(t,y(:,2));
    title('Angle q2 vs time')
    ylabel('q2');
    xlabel('t');
    
    subplot(5,4,18)
    plot(t,y(:,3));
    title('Angle q3 vs time')
    ylabel('q3');
    xlabel('t');
    
    % plot the hip position
    subplot(5,4,[1 2])
    plot(t,x_h)
    title('Hip position')
    xlabel('t');
    ylabel('x_h');
    
    subplot(5,4,[5 6])
    plot(t,z_h)
    title('Hip position')
    xlabel('t');
    ylabel('z_h');
    
    % plot instantaneous and average velocity
    subplot(5,4,[3 7])
    plot(t,dx_h)
    title('Velocity')
    xlabel('t');
    ylabel('$\dot{x}_h$', 'Interpreter','latex');
    
    subplot(5,4,[4 8])
    
    plot(t,movmean(dx_h,1000))
    title('Mean velocity')
    xlabel('t');
    ylabel('$\dot{z}_h$', 'Interpreter','latex');
    % plot projections of the limit cycle
    
    
    % plot actuation
    subplot(5,4,[11 15])
    plot(t,u(:,1))
    title('U_1 actuator')
    xlabel('t');
    ylabel('u_1');
    
    subplot(5,4,[12 16])
    plot(t,u(:,2))
    title('U_2 actuator')
    xlabel('t');
    ylabel('u_2');
    

end
if to_plot_gait
    figure('Name','Gait','Numbertitle','off')
    x = 1:length(gait_len);
    plot(x,gait_len,'b+')%,x,polyval(polyfit(x, gait_len,3),x),'r-');
    title('Gait length')
    xlabel('t');
    ylabel('Step length');
    legend('gait length','fit of the datapoints');
end

% Plot neuron oscillator stuff
if (to_plot_all || to_plot_NO)
    

    
    figure('Name','Neuron Oscillator Values','Numbertitle','off')
    subplot(3,2,1)
    plot(t,y(:,7))
    title('x1');
    xlabel('t');
    ylabel('x1');
    
    subplot(3,2,2)
    plot(y(:,9),y(:,7))
    title('x1~teta');
    xlabel('teta');
    ylabel('x1');
    
    subplot(3,2,3)
    plot(t,y(:,8))
    title('x2');
    xlabel('t');
    ylabel('x2');
    
    subplot(3,2,4)
    plot(y(:,9),y(:,8))
    title('x2~teta');
    xlabel('teta');
    ylabel('x2');
    
    subplot(3,2,5)
    plot(t,y(:,9),'b',t,pi,'-r')
    title('teta');
    xlabel('t');
    ylabel('teta');
    
    subplot(3,2,6)
    plot(t,y(:,9),'b',t,pi,'-r')
    title('teta');
    xlabel('t');
    ylabel('teta');
end


end
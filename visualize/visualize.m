%%
% This function takes the configuration of the 3-link model and plots the 
% 3-link model. 
% q = [q1, q2 ,q3] the generalized coordinates. Try different angles to see
% if your formulas for x1, z1, etc. makes sense. Example: q = [-pi/6, pi/6,
% pi/8]
%%
function visualize(q)

    [~, ~, ~, l1, l2, l3, ~] = set_parameters;
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    
    % Position of mass points
    x1 = -(l1*0.5*sin(q1));
    z1 = l1*0.5*cos(q1);
    x2 = -(l1*sin(q1)+l2*0.5*sin(q2));
    z2 = l1*cos(q1)-l2*0.5*cos(q2);
    x3 = -l1*sin(q1)+l3*0.5*sin(q3);
    z3 = l1*cos(q1)+l3*0.5*cos(q3);
    
    % Position of joint tips
    x_h = -l1*sin(q1);
    z_h = l1*cos(q1);
    
    x_t = x_h + l3*sin(q3);
    z_t = z_h + l3*cos(q3);
    
    x_swf = x_h - l2*sin(q2);
    z_swf = z_h - l2*cos(q2);
    
    %% 
    % Here plot a schematic of the configuration of three link biped at the
    % generalized coordinate q = [q1, q2, q3]:
    close all
    lw = 2;
    
    % links
    % link1: HIP TO STANCE FOOT
    plot([0, x_h], [0, z_h], 'linewidth', lw); 
    hold on
    
    % link2: HIP TO SWING FOOT
    plot([x_h, x_swf], [z_h, z_swf], 'linewidth', lw); 
    hold on
    
    % link3 : HIP TO TOP
    plot([x_h, x_t], [z_h, z_t], 'linewidth', lw); 
    hold on
    
    axis 'square'
    xlim([-1, 1]);
    ylim([0, 1.2]);
    % point masses
    mz = 40;
    % m1
    plot(x1, z1, '.', 'markersize', mz); 
    hold on
    
    % m2
    plot(x2, z2, '.', 'markersize', mz); 
    hold on
    
    % m3
    plot(x3, z3, '.', 'markersize', mz); 
end

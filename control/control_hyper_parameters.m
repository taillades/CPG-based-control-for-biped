% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters(step_number)
kp1 = 457.5;
kp2 = 161;
kd1 = 77.05;                     
kd2 = 5;
alpha = 10.4 * pi / 180;
omega = 8.92;
gamma = 90;
K = 0;
parameters = [kp1, kp2, kd1, kd2, alpha, omega, gamma, K]';
end

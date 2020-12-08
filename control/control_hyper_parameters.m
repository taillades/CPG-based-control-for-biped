% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters(step_number)
load('param_opt') % use the same parameters such that we don't reiterate the same optimization calculus at each run
kp1 = param_opt(10);
kp2 = param_opt(11);
kd1 = param_opt(12);               
kd2 = param_opt(13);
kp1 = 457.5;
kp2 = 161 *1.5;
kd1 = 77.05;                     
kd2 = 5 ;
alpha = param_opt(14);
omega = 1.4*2*pi; %param_opt(15); %   => VITESSE DES PAS
gamma = 90;param_opt(16); %   => REACTIVITE
K =     param_opt(17);
parameters = [kp1, kp2, kd1, kd2, alpha, omega, gamma, K]';
end

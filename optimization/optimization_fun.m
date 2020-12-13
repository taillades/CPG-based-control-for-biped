function objective_value = optimization_fun(hyper_parameters)

% extract parameters q0, dq0 and x
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8]; 
n0 = [30; -11.5; 0];
x = hyper_parameters;
fun_g = load('fun_g');

% run simulation
num_steps = 30; % the higher the better, but slow
no_noise = zeros(num_steps,3);
sln = solve_eqns(q0, dq0, n0, num_steps, x, fun_g.fun_g, no_noise);
results = analyse(sln, x, false, false, false);

% calculate metrics such as distance, mean velocity and cost of transport
max_actuation = 30;
gait_mean = results(:,5);
gait_std = results(:,9);
distance = results(:,1);
velocity = results(:,3); %corresponding to sp_mean on analyse.m, can be changed
CoT = results(:,6); % weird that it can become negative...
hip_min = results(:,7);
hip_start = results(:,8);
gait_freq = results(:,10);
% Name weights
w1 = 1; % go fast
w2 = 1000; % don't fall
w3 = 50;
w4 = 50;

% fastest as possible
%objective_value = -w1*velocity+ max(0,0.8*hip_start-hip_min)*w2;

% slowest as possible
objective_value = w1*velocity+ max(0,0.8*hip_start-hip_min)*w2;

% to max step frequency 
% objective_value = -w1*abs(distance)+ max(0,0.8*hip_start-hip_min)*w2 - w3*gait_freq;

% to min step frequency 
% objective_value = -w1*abs(distance)+ max(0,0.8*hip_start-hip_min)*w2 + w3*gait_freq;

% for self-selected step length
% objective_value = -w1*abs(distance)+ max(0,0.8*hip_start-hip_min)*w2 + w3*gait_mean - w4*gait_std^2;

% for short step length
%objective_value = -w1*abs(distance)+ max(0,0.8*hip_start-hip_min)*w2 + w3*gait_mean + w4*gait_std^2;

% for long step length
% objective_value = -w1*abs(distance)+ max(0,0.8*hip_start-hip_min)*w2 - w3*gait_mean + w4*gait_std^2;

% longest horizon possible
% objective_value = -w1*abs(distance)+ max(0,0.8*hip_start-hip_min)*w2;
% handle corner case when model walks backwards (e.g., objective_value =
% 1000)

% handle case when model falls (e.g., objective_value = 1000)

end


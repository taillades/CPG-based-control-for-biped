function objective_value = optimziation_fun(parameters)

% extract parameters q0, dq0 and x
q0 = parameters(1:3);
dq0 = parameters(4:6);
n0 = parameters(7:10);
x = parameters(11:end);

% run simulation
num_steps = 10; % the higher the better, but slow
sln = solve_eqns(q0, dq0, n0, num_steps, x);
results = analyse(sln, x, false);

% calculate metrics such as distance, mean velocity and cost of transport
max_actuation = 30;
effort = results(:,5);
distance = results(:,1);
velocity = results(:,3) %corresponding to sp_mean on analyse.m, can be changed
CoT = results(:,6) % weird that it can become negative...

% Name weights
w1 = 1; w2 = 1;
objective_value = w1*velocity + w2*abs(CoT);

% handle corner case when model walks backwards (e.g., objective_value =
% 1000)

% handle case when model falls (e.g., objective_value = 1000)

end


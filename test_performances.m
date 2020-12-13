clc;
clear;
close all;

% optimize
% optimize the initial conditions and controller hyper parameters
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8]; 
n0 = [30; -11.5; 0];
fun_g = g('full','suite');
save('fun_g','fun_g');
x0 = [q0; dq0; n0; control_hyper_parameters()];

load('param_opt');
internal_noise = 0;

%% THIS PART IS TO DO LOCAL OPTIMIZATION, AVAILABLE
% use fminsearch and optimset to control the MaxIter
options = optimset('TolX',0.2,'MaxIter',30,'display','iter');
%optimize only omega, gamma, K
param_opt(10:17) = fminsearch(@optimization_fun,x0(10:17),options)
save('param_opt','param_opt');

%% simulate solution
clc
close all;
param_opt(10:end) = control_hyper_parameters;
% extract parameters
q0 = param_opt(1:3);
dq0 = param_opt(4:6);
n0 = param_opt(7:9);
x_opt = param_opt(10:end);

% simulate
num_steps = 50;
if internal_noise
    noise = normrnd(-0,0.12,[num_steps,3]);
else
    noise = zeros(num_steps,3);
end
sln = solve_eqns(q0, dq0, n0, num_steps, x_opt, fun_g, noise);
% animate(sln);
results = analyse(sln, x_opt,0,1);
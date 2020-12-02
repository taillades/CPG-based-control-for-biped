clc;
clear;
close all;

% optimize
% optimize the initial conditions and controller hyper parameters
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8]; 
n0 = [0.01; 0.002; 0.008; 0.006; -0.01; -0.002; -0.008; -0.006]; % ne_sw, nf_sw, dne_sw, dnf_sw, ne_st, nf_st, dne_st, dnf_st 
x0 = [q0; dq0; n0; control_hyper_parameters()];

% use fminsearch and optimset to control the MaxIter
options = optimset('TolFun',1e-2,'MaxIter',30,'display','iter');
param_opt = fminsearch(@optimziation_fun,x0,options)

%% simulate solution
clc
close all;

% extract parameters
q0 = param_opt(1:3);
dq0 = param_opt(4:6);
n0 = param_opt(7:14);
x_opt = param_opt(15:end);

% simulate
num_steps = 15;
sln = solve_eqns(q0, dq0, n0, num_steps, x_opt);
animate(sln);
results = analyse(sln, x_opt, true);
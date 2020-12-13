clc;
clear;
close all;

% NAME FOR WHO WE OPTIMIZE
what_do_we_opt = 'opt_param_set/min_freq_parameters';

% set the initial conditions and controller hyper parameters
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8]; 
n0 = [30; -11.5; 0];
fun_g = g;
load(what_do_we_opt, 'x')
x_opt = x;

% simulate
num_steps = 20;
%noise = normrnd(-0.45,0.45,[num_steps,6]);
noise = zeros(num_steps,6);
sln = solve_eqns(q0, dq0, n0, num_steps, x_opt, fun_g, noise);
%animate(sln);
results = analyse(sln, x_opt,0,0,0);


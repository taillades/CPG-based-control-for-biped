clc;
clear;
close all;


% run simulation
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8]; 
n0 = [30; -11.5; 0];
    
num_steps = 10;

default_parameters = control_hyper_parameters();
sln = solve_eqns(q0, dq0, n0, num_steps, default_parameters);
animate(sln);
analyse(sln, default_parameters, true);
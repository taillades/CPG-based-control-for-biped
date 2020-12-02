clc;
clear;
close all;



% run simulation
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8]; 
n0 = [0.01; 0.002; 0.008; 0.006; -0.01; -0.002; -0.008; -0.006]; % ne_sw, nf_sw, dne_sw, dnf_sw, ne_st, nf_st, dne_st, dnf_st 

num_steps = 10;

default_parameters = control_hyper_parameters();
sln = solve_eqns(q0, dq0, n0, num_steps, default_parameters);
animate(sln);
analyse(sln, default_parameters, true);
clc;
clear;
close all;

% NAME FOR WHO WE OPTIMIZE
global what_do_we_opt;
what_do_we_opt = 'opt_param_set/slowest_parameters';
% optimize
% optimize the initial conditions and controller hyper parameters
q0 = [pi/9; -pi/9; 0];
dq0 = [0; 0; 8]; 
n0 = [30; -11.5; 0];
fun_g = g;
save('fun_g','fun_g');
x0 = [q0; dq0; n0; control_hyper_parameters];

%% THIS PART IS TO DO LOCAL OPTIMIZATION, AVAILABLE
% use fminsearch and optimset to control the MaxIter
delete 'param_opt.mat'
options = optimset('OutputFcn', @outfun, 'TolX', 0.2, 'TolFun', 0.2, 'MaxIter',30,'display','iter');
%optimize only omega, gamma, K

param_opt = fminsearch(@optimization_fun,x0(10:17),options)


%% TO SAVE RESULTS
try 
    load('param_opt.mat', 'x')
    param_opt = x
end

save(what_do_we_opt,'x');

%% simulate solution
clc
close all;
% extract parameters
load(what_do_we_opt, 'x')
x_opt = x;

% simulate
num_steps = 30;
noise = normrnd(-0,0.12,[num_steps,3]);
noise = zeros(num_steps,3);
sln = solve_eqns(q0, dq0, n0, num_steps, x_opt, fun_g, noise);
animate(sln);
results = analyse(sln, x_opt,0,0,1);


%% THIS PART IS TO DO GLOBAL OPTIMIZATION, AVAILABLE
problem = createOptimProblem('fmincon',...
    'objective',@(x)optimization_fun(x),...
    'x0',param_opt,'options',...
    optimoptions(@fmincon,'Algorithm','sqp','Display','off'));
param_opt(10:17) = fmincon(problem);
gs = GlobalSearch('Display','iter');
rng(14,'twister') % for reproducibility
[x,fval] = run(gs,problem)
save('param_opt','param_opt');


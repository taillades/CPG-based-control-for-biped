function dy = eqns(t, y, y0, step_number, parameters, fun_g, noise)

% extract parameters 
omega = parameters(6);
gamma = parameters(7);
K = parameters(8);

% extract variables
q = [y(1); y(2); y(3)];
dq = [y(4); y(5); y(6)];
q0 = [y0(1); y0(2); y0(3)];
dq0 = [y0(4); y0(5); y0(6)];
x1 = min(30,max(-30,y(7)));
x2 = min(30,max(-30,y(8)));
teta = y(9);

% Get matrix for the q derivative stuff
M = eval_M(q);
C = eval_C(q, dq);
G = eval_G(q);
B = eval_B();

% Compute desried pattern functions

g1 = fun_g.g1;
g2 = fun_g.g2;
dg1 = fun_g.dg1;
dg2 = fun_g.dg2;

% Compute control 
u_pd = control(t, q, dq, q0, dq0, step_number, parameters); 
u_ff = [x1 ; x2];
ratio = 0.5; %u_ff vs u_pd ratio in control
% Formulate the differential equations
dy = zeros(9, 1);

%ADD INTERNAL DISTURBANCE
% artificial random could have been made like this
% amplitude = 5;
% prime_numbers = [467 389 397 379 269 311 293 491 449];
% smaller_prime_numbers = [5 7 11];
% s = smaller_prime_numbers;
% variables = [q; dq; x1; x2; teta];
% big_number = prime_numbers*variables;

% dq1, dq2, dq3 
%dy(1) = y(4);%+ amplitude*(mod(big_number,s(1))-s(1)/2)/s(1);
%dy(2) = y(5);%+ amplitude*(mod(big_number,s(2))-s(2)/2)/s(2);
%dy(3) = y(6);%+ amplitude*(mod(big_number,s(3))-s(3)/2)/s(3);

dy(1) = y(4) + noise(1);
dy(2) = y(5) + noise(2);
dy(3) = y(6) + noise(3);

% q1, q2, q3
dy(4:6) = M \ (-C*dq - G + B*(ratio*u_ff + (1-ratio)*u_pd)) + noise(4:6)'; 

% Following the pattern
dy(7) = gamma*(g1(teta)-x1) + dg1(teta)*omega + K;
dy(8) = gamma*(g2(teta)-x2) + dg2(teta)*omega + K;
dy(9) = omega;


























end
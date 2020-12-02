function dy = eqns(t, y, y0, step_number, parameters)
% n this is the dimension of the ODE, note that n is 2*DOF, why? 
% y1 = q1, y2 = q2, y3 = q3, y4 = dq1, y5 = dq2, y6 = dq3
% y7 = ne_sw, y8 = nf_sw, y9 = dne_sw, y10 = dnf_sw
% y11 = ne_st, y12 = nf_st, y13 = dne_st, y14 = dnf_st
% y0 is the states right after impact

g = load('g');

% extract parameters
w_st2sw = parameters(1);
w_sw2st = parameters(2);
w_st2sh = parameters(3);
w_sw2sh = parameters(4);
Si = parameters(6);
sw_in_gain = parameters(7); %could be different for the 2 NO
sw_fb_gain = parameters(8); %could be different for the 2 NO
out_gain = parameters(9);
A = parameters(10);
bi = parameters(11);
ta = parameters(12);
tr = parameters(13);
st_in_gain = parameters(14); %could be different for the 2 NO
st_fb_gain = parameters(15); %could be different for the 2 NO
sh_in_gain = parameters(16);

% extract variables => what y(i) corresponds to what
q = [y(1); y(2); y(3)];
dq = [y(4); y(5); y(6)];
q0 = [y0(1); y0(2); y0(3)]; % I dont know if it's really useful for us
dq0 = [y0(4); y0(5); y0(6)];
ne_sw = y(7);
nf_sw = y(8);
dne_sw = y(9);
dnf_sw = y(10);
ne_st = y(11);
nf_st = y(12);
dne_st = y(13);
dnf_st = y(14);
ye_sw = dne_sw*tr;
yf_sw = dnf_sw*tr;
ye_st = dne_st*tr;
yf_st = dnf_st*tr;

% Get matrix for the q derivative stuff
M = eval_M(q);
C = eval_C(q, dq);
G = eval_G(q);
B = eval_B();

% Let's simplify the differential equations system
    function output = MEQ1(n, y_other, dn, input, gain)
        output = (- n - A * y_other - bi * dn + gain*input + Si)/tr;
    end
    function output = MEQ2(dn, y)
        output = ((- dn + max(y,0))/ta);
    end
% Now the real Neural Oscillator equations
dy = zeros(14, 1);
dy(1) = y(4);%+ w_st2sw*(y(1)-y(2)-pi);
dy(2) = y(5);%+ w_sw2st*(y(2)-y(1)-pi);
dy(3) = y(6); % - w_st2sh*y(1) - w_sw2sh*y(2);
% I pretend output of NN is u, dimension 2
u    = out_gain*[ye_sw-yf_sw;ye_st-yf_st];
u_pd = control(t, q, dq, q0, dq0, step_number, parameters); 

dy(4:6) = M \ (-C*dq - G + B*(0*u+1*u_pd)); % [sw_in_gain;st_in_gain;sh_in_gain].*B*tan(out_gain.*[ye_st-yf_st;ye_sw-ye_sw])); %B*u
% swing leg
dy(7) = MEQ1(ne_sw, yf_sw, dne_sw, q(2), sw_fb_gain);    % consider that swing uses q2 and stance q1
dy(8) = MEQ1(nf_sw, ye_sw, dnf_sw, q(2), sw_fb_gain);
dy(9) = MEQ2(dne_sw, ye_sw);
dy(10)= MEQ2(dnf_sw, yf_sw);
% stance leg
dy(11) = MEQ1(ne_st, yf_st, dne_st, q(1), st_fb_gain); % consider that swing uses q2 and stance q1
dy(12) = MEQ1(nf_st, ye_st, dnf_st, q(1), st_fb_gain);
dy(13) = MEQ2(dne_st, ye_st);
dy(14) = MEQ2(dnf_st, yf_st);































end
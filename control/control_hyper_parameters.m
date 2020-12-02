% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters(step_number)
w_st2sw = 1;
w_sw2st = 1;
ta = 0.75;
tr = 0.05;
alpha = 10.4*pi/180;
Si = 1;
in_gain = 0.2;
fb_gain = 0.3;
out_gain = 1*7;
A = 2.5; %wtf is that I don't know
bi = 0; %in case we want friction

parameters = [w_st2sw, w_sw2st, ta, tr, alpha, Si, in_gain, fb_gain, out_gain, A, bi]';

end

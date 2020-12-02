% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function parameters = control_hyper_parameters(step_number)
w_st2sw = 1.0275;
w_sw2st = 0.9980;
w_st2sh = 0.2; 
w_sw2sh = -0.2;
alpha = 10.4*pi/180;
Si = 8;
sw_in_gain = 0.2;
sw_fb_gain = 0.3;
out_gain = 7;
A = 2.5; %wtf is that I don't know
bi = 0; %in case we want friction
ta = 0.75;
tr = 0.05;
st_in_gain = 0.2;
st_fb_gain = 0.3;
sh_in_gain = 0.1;
parameters = [w_st2sw, w_sw2st, w_st2sh, w_sw2sh, alpha, Si, sw_in_gain, sw_fb_gain, out_gain, A, bi, ta, tr,st_in_gain, st_fb_gain,sh_in_gain]';

end

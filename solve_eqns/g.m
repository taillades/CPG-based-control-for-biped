function fun_g = g()
g1 = load('g1.mat');
g2 = load('g2.mat');
g1.u1 = [g1.u1 g1.u1];
g2.u2 = [g2.u2 g2.u2];

len = 2*round(length(g1.u1)/2);
fun_g = struct;

fun_g.g1 = @(teta) g1.u1(round(mod(teta,pi)/pi*len)+1);
fun_g.dg1 = @(teta) min(100,max(-100,diff(g1.u1([round(mod(teta,pi)/pi*(len-1)) round(mod(teta,pi)/pi*len)+1]+1))));
fun_g.g2 = @(teta) g2.u2(round(mod(teta,pi)/pi*len)+1);
fun_g.dg2 = @(teta) min(100,max(-100,diff(g2.u2([round(mod(teta,pi)/pi*(len-1)) round(mod(teta,pi)/pi*len)+1]+1))));

end
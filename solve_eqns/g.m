function fun_g = g(pattern, mode)
g1 = load('g1.mat');
g2 = load('g2.mat');
g1.u1 = [g1.u1 g1.u1];
g2.u2 = [g2.u2 g2.u2];
display = 0;
len = 2*round(length(g1.u1)/2);
fun_g = struct;
if strcmp(mode, 'polynomial')
    if strcmp(pattern, 'mixted')
        p1 = polyfit(linspace(0,pi,len),[g1.u1(1:len/2) g2.u2(len/2+1:end)],10);
        p2 = polyfit(linspace(0,pi,len),[g2.u2(len/2+1:end) g1.u1(1:len/2)],10);
    end
    if strcmp(pattern, 'full')
        p1 = polyfit(linspace(0,pi,len),g1.u1(1:len),10);
        p2 = polyfit(linspace(0,pi,len),g2.u2(1:len),10);
    end
    
    dp1 = polyder(p1);
    dp2 = polyder(p2);
    fun_g.g1 = @(teta) max(-30,min(30,polyval(p1,max(0,min(pi,teta)))));
    fun_g.dg1 = @(teta) polyval(dp1,teta);
    fun_g.g2 = @(teta) max(-30,min(30,polyval(p2,max(0,min(pi,teta)))));
    fun_g.dg2 = @(teta) polyval(dp2,teta);
end

if strcmp(mode, 'suite')
    % only option is full
    fun_g.g1 = @(teta) g1.u1(round(mod(teta,pi)/pi*len)+1);
    fun_g.dg1 = @(teta) min(100,max(-100,diff(g1.u1([round(mod(teta,pi)/pi*(len-1)) round(mod(teta,pi)/pi*len)+1]+1))));
    fun_g.g2 = @(teta) g2.u2(round(mod(teta,pi)/pi*len)+1);
    fun_g.dg2 = @(teta) min(100,max(-100,diff(g2.u2([round(mod(teta,pi)/pi*(len-1)) round(mod(teta,pi)/pi*len)+1]+1))));
end

if display
    x = 1:length(g1);
    figure
    subplot(2,1,1)
    plot(x, g1.u1, x, fun_g.g1(x));
    subplot(2,1,2)
    plot(x, g2.u2, x, fun_g.g2(x));
end

end
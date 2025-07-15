rng(37,'twister');
n = 100;
x = exprnd(2,n,1);

x = sort(x);
p = ((1:n)-0.5)' ./ n;

muMLE = expfit(x)

stairs(x,p,'k-');
hold on
xgrid = linspace(0,1.1*max(x),100)';
plot(xgrid,expcdf(xgrid,muMLE),'b--');
hold off
xlabel('x'); ylabel('Cumulative Probability (p)');
legend({'Data','LS Fit','ML Fit'},'location','southeast');
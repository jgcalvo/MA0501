% Ejercicio 2.28
g = @(x) 816*x.^3-3835*x.^2+6000*x-3125;

% (a) fzero
r1 = fzero(g,1.5);
r2 = fzero(g,1.6);
r3 = fzero(g,1.7);

% (b) 
% vector valores iniciales
x0 = linspace(1.4,1.7); 
ck = zeros(numel(x0),1);
for j = 1:numel(x0)
    [c,~] = newton(g,x0(j),1e-8);
    ck(j) = c;
end
plot(x0,ck,'.','MarkerSize',10), hold on
plot(r1,x0,'.k','LineWidth',2)
plot(r2,x0,'.k','LineWidth',2)
plot(r3,x0,'.k','LineWidth',2)
axis([1.4 1.7 1.4 1.7])
grid on

function [c1,k] = newton(f,c0,tol)
k = 1;
c1 = c0 - f(c0)/deriv(f,c0);
while(abs(c1-c0)>tol)
c0 = c1;    
c1 = c0 - f(c0)/deriv(f,c0);
k = k+1;
end
end

function df = deriv(f,x0)
h = 1e-6;
df = (f(x0+h)-f(x0-h))./(2*h);
end
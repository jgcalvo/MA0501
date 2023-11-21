% Problema de Valor de Frontera y''+q y = f con y(0)=alpha, y(1)=beta
% parametros
T = 1;    % intervalo [0,T]
n = 1000; % cantidad de subintervalos
h = T/n;
tk = linspace(0,T,n+1);
alpha = 0;
beta  = 0;
q = 1;
f = @(x) x;
a = 2+h^2*q;
% matriz
% 1) forma densa, problemas de memoria
%A = diag(a*ones(n-1,1))+diag(-ones(n-2,1),1)+diag(-ones(n-2,1),-1);
% 2) forma sparse
ii = [1:n-1, 2:n-1, 1:n-2]';
jj = [1:n-1, 1:n-2, 2:n-1]';
ss = [a*ones(n-1,1); -ones(n-2,1); -ones(n-2,1)];
A = sparse(ii,jj,ss,n-1,n-1);
% lado derecho
b = nan(n-1,1);
for j = 1:n-1
    b(j) = h^2*f(tk(j+1));
end
b(1) = b(1) + alpha;
b(end) = b(end) + beta;
% solucion
yk = A\b;
yk = [alpha; yk; beta]; % incluyo valores de frontera
% plot
plot(tk,yk)
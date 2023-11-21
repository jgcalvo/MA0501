% Implementacion Runge Kutta 4
T = 2; % tiempo máximo
tt = linspace(0,T); % para graficar
n  = 100;  % numero de intervalos
h  = T/n; % diametro de intervalos
f = @(t,y) [y(2) y(1)];
% sol. exacta
yex = @(t) exp(t)+exp(-t);
% RK4
a = [0 0 0 0; .5 0 0 0; 0 .5 0 0; 0 0 1 0];
b = [1 2 2 1]/6;
c = [0 .5 .5 1];
tk = linspace(0,T,n+1);
ykRK = nan(n+1,2); % primer columna: y, segunda y'
ykRK(1,:) = [2 0]; % condicion inicial
for k = 1:n
    xi1 = ykRK(k,:);
    xi2 = ykRK(k,:)+h*a(2,1)*f(tk(k)+c(1)*h,xi1);
    xi3 = ykRK(k,:)+h*(a(3,1)*f(tk(k)+c(1)*h,xi1)+a(3,2)*f(tk(k)+c(2)*h,xi2));
    xi4 = ykRK(k,:)+h*(a(4,1)*f(tk(k)+c(1)*h,xi1)+a(4,2)*f(tk(k)+c(2)*h,xi2)+...
        a(4,3)*f(tk(k)+c(3)*h,xi3));
    ykRK(k+1,:) = ykRK(k,:)+h*(b(1)*f(tk(k)+c(1)*h,xi1)+b(2)*f(tk(k)+c(2)*h,xi2)+...
        b(3)*f(tk(k)+c(3)*h,xi3) + b(4)*f(tk(k)+c(4)*h,xi4));
end
figure(1), clf
plot(tk,ykRK(:,1),'.-'), hold on
plot(tt,yex(tt),'--')

% error
figure(2),clf
semilogy(tk,abs(ykRK(:,1)-yex(tk)'),'.-')
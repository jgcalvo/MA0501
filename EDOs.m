T = 2; % tiempo máximo
tt = linspace(0,T); % para graficar
n  = 10;  % numero de intervalos
h  = T/n; % diametro de intervalos
% sol. exacta
yex = @(t) exp(t)+exp(-t);
plot(tt,yex(tt))
	
% Metodo de Euler
tk = linspace(0,T,n+1);
yke = nan(n+1,2); % primer columna: y, segunda y'
yke(1,:) = [2 0]; % condicion inicial
for k = 2:n+1
    yke(k,:) = yke(k-1,:)+h*yke(k-1,[2 1]);
end
clf
plot(tk,yke(:,1),'.-'), hold on
plot(tt,yex(tt),'--')

% error
figure(2),clf
semilogy(tk,abs(yke(:,1)-yex(tk)'),'.-')

% Metodo de trapecio
n  = 61;  % numero de intervalos
h  = T/n; % diametro de intervalos
tk = linspace(0,T,n+1);
ykt = nan(n+1,2); % primer columna: y, segunda y'
ykt(1,:) = [2 0]; % condicion inicial
for k = 2:n+1
    %yk(k,:) = yk(k-1,:)+h*yk(k-1,[2 1]);
    % resolver sistema
    M = [1 -h/2; -h/2 1];
    rhs = [ykt(k-1,1)+h/2*ykt(k-1,2);ykt(k-1,2)+h/2*ykt(k-1,1)];
    sol = M\rhs;
    % guardo solucion
    ykt(k,:) = sol;
end
figure(3), clf
plot(tk,ykt(:,1),'.-'), hold on
plot(tt,yex(tt),'--')

% error
figure(4),clf
semilogy(tk,abs(ykt(:,1)-yex(tk)'),'.-')

% Metodo predictor/corrector
n  = 100;  % numero de intervalos
h  = T/n; % diametro de intervalos
tk = linspace(0,T,n+1);
ykp = nan(n+1,2); % primer columna: y, segunda y'
ykp(1,:) = [2 0]; % condicion inicial
for k = 2:n+1
    %ykp(k,:) = ykp(k-1,:)+h*ykp(k-1,[2 1]);
    ypred = ykp(k-1,:)+h*ykp(k-1,[2 1]);
    ykp(k,:) = ykp(k-1,:) + h/2*(ykp(k-1,[2 1])+ypred([2 1]));
end
figure(5),clf
plot(tk,ykp(:,1),'.-'), hold on
plot(tt,yex(tt),'--')

% error
figure(6),clf
semilogy(tk,abs(ykp(:,1)-yex(tk)'),'.-')

% Con MATLAB
f = @(t,y) [y(2);y(1)]; % y: vector
% NO: f = @(t,y1,y2) [y2;y1]; 
[tode,yode]=ode45(f,[0 T],[2 0]);
figure(7),clf
plot(tode,yode(:,1),'.-'), hold on
plot(tt,yex(tt),'--')

% error
figure(8),clf
semilogy(tode,abs(yode(:,1)-yex(tode)),'.-')

%%
options = odeset('RelTol',1e-6,'AbsTol',1e-6,'Stats','on');

mu = 1000;
f  = @(t,y) [y(2); mu*(1-y(1).^2).*y(2)-y(1)];
y0 = [2;0];
tic
[t,y] = ode15s(f,[0,3000],y0,options);
figure(9)
plot(t,y(:,1),'-')



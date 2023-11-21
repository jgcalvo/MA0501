%% trazadores 
% lineal - interp1
n = 5;
f = @(x) 1./(1+25*x.^2);
xi = linspace(-1,1,n+1);
yi = f(xi);
figure(1)
clf
plot(xi,yi,'.','MarkerSize',15)
xx = linspace(-1,1,100);
yy = interp1(xi,yi,xx,'next'); % linear, pchip
hold on 
plot(xx,yy,'k'),
plot(xx,f(xx),'--')

figure(2) % error
clf 
semilogy(xx,abs(f(xx)-yy))

% lagrange - implementamos la formula que vimos en clase 

n = 25;
f = @(x) 1./(1+25*x.^2);
%xi = linspace(-1,1,n+1); % puntos equidistantes
xi = cos((0:n)*pi/n); % puntos de Chebyshev
yi = f(xi);

% graficar
xx = linspace(min(xi),max(xi));
yy = nan(size(xx));
for j = 1:numel(xx)
    yy(j) = lagrangeClase(xi,yi,xx(j));
end
figure(1), clf
plot(xx,yy,'k'), hold on
plot(xi,yi,'.r','MarkerSize',15)
plot(xx,f(xx),'--')

function p = lagrangeClase(xi,yi,x)
n = numel(xi)-1;
p = 0; % resultado
for k = 0:n
    Lk = 1;
    for i = 0:n
        if(i~=k)
            Lk = Lk*(x-xi(i+1))/(xi(k+1)-xi(i+1));
        end
    end
    p = p + yi(k+1)*Lk;
end
%disp(p)
end


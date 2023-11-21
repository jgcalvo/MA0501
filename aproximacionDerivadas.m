% ejemplo, Seccion 1.6.1
% aproximar derivadas
% soluciones
% f'(x0) = lim_{h -> 0} (f(x0+h)-f(x0))/(h)
% aprox: tome h pequeño, f'(x0) \approx (f(x0+h)-f(x0))/(h)
% Ejercicio 1.16: f'(x0) = (f(x0+h)-f(x0))/(h) + O(h)
clear all

% medir tiempo, tic, toc
tic
clf % limpiar figura
f  = @(x) sin(x) + exp(x).*cos(x); % funcion
fd = @(x) cos(x) + exp(x).*(-sin(x) + cos(x));% derivada exacta de la funcion
x0 = 1;

%h = .001;
%der = (f(x0+h)-f(x0))/h;
%err = abs(fd(x0)-der); % error absoluto
%err = abs((fd(x0)-der)/fd(x0)) % error relativo
fdx0 = fd(x0); % valor exacto de la derivada
%hh = linspace(0,1); % no me da valores pequeños de h
%hh = 10.^-(linspace(0,15));
hh = 10.^-(0:15);
%errorDer = []; % vector vacío
%errorDer2 = []; % vector vacío
errorDer = nan(size(hh));
errorDer2 = nan(size(hh));
pt = 0;
for h = hh
    der1 = (f(x0+h)-f(x0))/h;
    der2 = deriv2(f,h,x0);
    err = abs((fdx0-der1)/fdx0); % error relativo
    err2 = abs((fdx0-der2)/fdx0); % error relativo
    % guardar error
    %errorDer = [errorDer; err];
    %errorDer2 = [errorDer2; err2];
    errorDer(pt+1) = err;
    errorDer2(pt+1) = err2;
    pt = pt +1;
end
loglog(hh,errorDer,'v-m','MarkerSize',15); hold on
loglog(hh,errorDer2,'x-k','MarkerSize',15);
xlabel('$h$','Interpreter','Latex')
ylabel('Error abs')
title('Aprox derivada')
legend('Orden1','Orden2')

time1 = toc;
%%% deben ir al final del script
% funciones
function der = deriv2(f,h,x0)
der = (f(x0+h)-f(x0-h))/(2*h);
end
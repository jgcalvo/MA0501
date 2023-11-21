% comparacion de metodos para resolver ecuaciones

f = @(x) exp(x) - 2*x - 1;
x0 = 1;
x1 = 2;
c = 1.256431208626170;          % valor exacto con 15 decimales
[rS,secS] = Secant(f,x0,x1);    % raiz y secuencia
[rB,secB] = Bisection(f,x0,x1); % para todos los metodos
[rN,secN] = Newton(f,x0);
[rI,secI] = iterSimple(@(x) log(2*x+1),x0); % x = ln(2x+1)

figure
semilogy(1:numel(secS),abs(secS-c)/abs(c),'.-','MarkerSize',14,...
    'LineWidth',2); hold on
semilogy(1:numel(secB),abs(secB-c)/abs(c),'.-','MarkerSize',14,...
    'LineWidth',2);
semilogy(1:numel(secN),abs(secN-c)/abs(c),'.-','MarkerSize',14,...
    'LineWidth',2);
semilogy(1:numel(secI),abs(secI-c)/abs(c),'.-','MarkerSize',14,...
    'LineWidth',2);
legend('Secante','Biseccion','Newton','IterSimple')
xlabel('$k$','Interpreter','Latex')
ylabel('Error relativo','Interpreter','Latex')
title('Comparaci\''on de m\''etodos','Interpreter','Latex')
set(gca,'FontSize',16,'fontWeight','bold')
set(findall(gcf,'type','text'),'FontSize',16,'fontWeight','bold')

function [root,seq] = Secant(f,x0,x1)
  Tol = 1e-8;
  iterMax = 100;
  count = 0;
  f0 = f(x0);
  f1 = f(x1);
  if(abs(f0)<Tol)     root = x0; seq = x0;
  elseif(abs(f1)<Tol) root = x1; seq = x1;
  else
      seq = zeros(iterMax,1);
      xNew = x1 - f1*(x1-x0)/(f1-f0);
      fNew = f(xNew);
      seq(count+1) = xNew;
      while(count<iterMax && abs(x1-x0)>Tol)
        count = count + 1;
        x0 = x1;
        x1 = xNew;
        f0 = f1;
        f1 = fNew;
        xNew = x1 - f1*(x1-x0)/(f1-f0);
        fNew = f(xNew);
        seq(count+1) = xNew;
      end
      root = xNew;
      seq = seq(1:count+1);
  end
end

function [root,seq]=Bisection(f,x0,x1)
  Tol = 1e-8;
  iterMax = 100;
  count = 0;
  f0 = f(x0);
  f1 = f(x1);
  if(f0*f1>0) fprintf('Cannot guarantee a root in the interval!!\n');
  elseif(abs(f0)<Tol) root=x0; seq = x0;
  elseif(abs(f1)<Tol) root=x1; seq = x1;
  else
    seq = zeros(iterMax,1);
    mid = (x0+x1)/2;
    fmid= f(mid);
    seq(count+1) = mid;
    while(count<iterMax && abs(fmid)>Tol)
      if(fmid*f0<0) 
          x1 = mid;
      else
          x0 = mid;
      end
      mid = (x0+x1)/2;
      fmid= f(mid);
      count = count + 1;
      seq(count+1) = mid;
    end
    root = mid;  
    seq = seq(1:count+1);
  end
  
end

function [root,seq] = iterSimple(f,x0)
Tol = 1e-8;
iterMax = 100;
k = 0;
seq = [x0 f(x0)];
while(abs(seq(end)-seq(end-1))>Tol && k<iterMax)
    seq = [seq f(seq(end))];
    k = k+1;
end
root = seq(end);
end

function [root,seq] = Newton(f,x0)
  Tol = 1e-8;
  iterMax = 100;
  count = 0;
  seq = x0;
  f0 = f(x0);
  if(abs(f0)<Tol) root = x0;
  else
      fprime = derivative(f,x0);
      xNew = x0 - f0/fprime;
      fNew = f(xNew);
      seq = [seq; xNew];
      while(count<iterMax && abs(x0-xNew)>Tol)
        count = count + 1;
        x0 = xNew;
        f0 = fNew;
        fprime = derivative(f,x0);
        xNew = x0 - f0/fprime;
        fNew = f(xNew);
        seq = [seq; xNew];
      end
      root = xNew;
  end
end

function der = derivative(f,x)
    h = 1e-7;
    der = (f(x+h)-f(x-h))/(2*h);
end
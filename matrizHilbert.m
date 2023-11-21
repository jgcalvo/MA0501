% matriz Hilbert -> ¡para todo n, H es invertible!
% H^{-1} tiene entradas enteras
% h_{ij} = 1/(i+j-1) = h_{ji};

n = 10;
h1 = zeros(n,n); 
h2 = zeros(n,n); 
% definir variables
% si n es alto, hay problemas de eficiencia si no se define
% manera 1 (directa)
%tic
for i = 1:n % filas
    for j = 1:n % columnas
        h1(i,j) = 1/(i+j-1);
    end
end
%toc

% manera 2 (vectorial -> optimizado)
%tic
for i = 1:n % fila
    h2(i,:) = 1./(i+(1:n)-1);
end
%toc

% manera 3 (directa, sin ningún for)
%tic
jj = 1:n;
h3 = 1./(jj'+jj-1);
%toc

% error para varios n
err     = nan(20,1);
numCond = nan(20,1);
for n = 1:20
    % manera 4 (Matlab = manera 3)
    H = hilb(n);
    % resolver sistema Hx=b
    xExact = ones(n,1);
    % lado derecho
    b = H*xExact;
    % resolución Matlab
    %xAprox = H\b;
    [Q,R] = qr(H); % factorizacion H = QR
    xAprox = R\(Q'*b);
    % error absoluto
    err(n) = norm(xExact-xAprox,2);
    % num cond de H
    numCond(n) = cond(H);
end

figure(1)
semilogy(err)
grid on
xlabel('$n$','Interpreter','Latex')

figure(2)
semilogy(numCond)
grid on

% calculemos valores singulares de H
[U,S,V] = svd(H); % n = 20
valSing = diag(S);
disp(valSing')
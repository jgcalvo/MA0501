% prueba con el triángulo unitario, área 1/2
verts = [0 0; 1 0; 0 1];
[areaTri,bariTri] = calculoAreaBaricentro(verts);

% cuadrado unitario
verts = [0 0; 1 0; 1 1; 0 1];
[areaCuadrado,bariCuadrado] = calculoAreaBaricentro(verts);


%% funciones
% Dados los vértices (x1,y1),...,(xN,yN) ordenados en sentido antihorario
% Área: 1/2*\sum_{i=1}^N (x_{i}y_{i+1}-x_{i+1}y_i)
% b1:   1/(6*A)*\sum_{i=1}^N (x_{i}+x_{i+1})*(x_{i}y_{i+1}-x_{i+1}y_i)
% b2:   1/(6*A)*\sum_{i=1}^N (y_{i}+y_{i+1})*(x_{i}y_{i+1}-x_{i+1}y_i)
% baricentro: [b1 b2]

% función: entradas (vértices), salida: A, b1, b2
% function [salidas] = nombreFuncion(entradas)
function [area,bari] = calculoAreaBaricentro(vertices)
% vertices: [x1 y1; x2 y2; x3 y3; ...; xN yV]; 
% area: número real
% baricentro: [b1 b2]
N = size(vertices,1); % número de filas corresponde al número de vértices
% cálculo del área
% Área: 1/2*\sum_{i=1}^N (x_{i}y_{i+1}-x_{i+1}y_i)
x = vertices(:,1); % componentes x de vertices
y = vertices(:,2); % componentes y de vertices
suma = 0;
% habíamos definido y(N+1) = y(1), x(N+1) = x(1)
for i = 1:N % cuando i = N, debemos accesar y(N+1) (no existe)
    if(i<N)
        suma = suma + (x(i)*y(i+1)-x(i+1)*y(i));
    else
        suma = suma + (x(i)*y(1)-x(1)*y(i));    %y(N+1) = y(1), x(N+1) = x(1)
    end
end
area = 1/2*suma;
% baricentro
% b1:   1/(6*A)*\sum_{i=1}^N (x_{i}+x_{i+1})*(x_{i}y_{i+1}-x_{i+1}y_i)
% b2:   1/(6*A)*\sum_{i=1}^N (y_{i}+y_{i+1})*(x_{i}y_{i+1}-x_{i+1}y_i)
b1 = 0;
b2 = 0;
for i = 1:N % cuando i = N, debemos accesar y(N+1) (no existe)
    if(i<N)
        b1 = b1 + (x(i)+x(i+1))*(x(i)*y(i+1)-x(i+1)*y(i));
        b2 = b2 + (y(i)+y(i+1))*(x(i)*y(i+1)-x(i+1)*y(i));
    else
        b1 = b1 + (x(i)+x(1))*(x(i)*y(1)-x(1)*y(i));
        b2 = b2 + (y(i)+y(1))*(x(i)*y(1)-x(1)*y(i));
    end
end
bari = [b1 b2]/(6*area);
end

function [area,bari] = calculoAreaBaricentroMejorado(vertices)
% vertices: [x1 y1; x2 y2; x3 y3; ...; xN yV]; 
% area: número real
% baricentro: [b1 b2]
% Área: 1/2*\sum_{i=1}^N (x_{i}y_{i+1}-x_{i+1}y_i)
% construimos un vector con entradas (x_{i}y_{i+1}-x_{i+1}y_i)
% i = 1:N
% x_{1:N}y_{2:N+1}-x_{2:N+1}y_{1:N}
x = [vertices(:,1); vertices(1,1)]; % componentes x de vertices cíclicos
y = [vertices(:,2); vertices(1,2)]; % componentes y de vertices cíclicos
sumandos = x(1:end-1).*y(2:end)-x(2:end).*y(1:end-1);
area  = sum(sumandos)/2;
sumb1 = (x(1:end-1)+x(2:end)).*sumandos;
sumb2 = (y(1:end-1)+y(2:end)).*sumandos;
bari  = [sum(sumb1) sum(sumb2)]/(6*area);
% baricentro
% b1:   1/(6*A)*\sum_{i=1}^N (x_{i}+x_{i+1})*(x_{i}y_{i+1}-x_{i+1}y_i)
% b2:   1/(6*A)*\sum_{i=1}^N (y_{i}+y_{i+1})*(x_{i}y_{i+1}-x_{i+1}y_i)
end


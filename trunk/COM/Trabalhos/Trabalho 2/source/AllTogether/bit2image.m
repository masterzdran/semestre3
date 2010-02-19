%
% ISEL - Instituto Superior de Engenharia de Lisboa.
%
% LEIC - Licenciatura em Engenharia Informatica e de Computadores.
%
% Com  - Comunica��es.
%
% bit2image.m
%
%
% Recebe:   rows, n�mero de linhas da matriz.
%           cols, n�mero de colunas da matriz.
%           bistream, vector no qual cada posi��o � um bit.
% Retorna:  I, matriz do tipo uint8 de dimens�es rows x cols. 
%
function  I = bit2image( rows, cols, bitstream )

% Criar a matriz com elementos do tipo inteiro a 8 bit.
I = uint8(zeros(rows,cols));

% Vector com as potencias de 2.
p2 = 2.^(7:-1:0);

% Calcular pixel a pixel.
k = 1;
for r=1: rows
    for c=1: cols
        % Cada pixel � obtido pela soma ponderada
        % pelas respectivas potencias de 2.
        I(r,c) = bitstream( k:k+7 ) * p2';
        k = k + 8;
    end
end
return;

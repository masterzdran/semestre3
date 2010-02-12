%
% ISEL - Instituto Superior de Engenharia de Lisboa.
%
% LEIC - Licenciatura em Engenharia Informatica e de Computadores.
%
% Com  - Comunica��es.
%
% 
%
% time1.m
% Fun��o de teste.
%
function time1()

% Limpar a consola.
clc;

% Dimens�o do vector.
vector_size = 2*10^7;

% Gerar vector de n�meros aleat�rios com a dimens�o definida.
x = randn(1, vector_size );

%-------------------------------------------------------------------------
% Calcular a soma e avaliar o tempo - forma 1
currentTime = fix(clock);
%currentTime = [year month day hour minute seconds]
fprintf(' Forma 1 - Start at %d:%d:%d \n', currentTime(4),...
    currentTime(5), currentTime(6));

t0 = cputime; 
s = 0;
for i=1: length(x)
    s = s + x(i);
end
t1 = cputime - t0;

currentTime = fix(clock);
fprintf(' Forma 1 - Stop  at %d:%d:%d \n', currentTime(4),...
    currentTime(5), currentTime(6));
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
% Calcular a soma e avaliar o tempo - forma 1
currentTime = fix(clock);
%currentTime = [year month day hour minute seconds]
fprintf(' Forma 2 - Start at %d:%d:%d \n', currentTime(4),...
    currentTime(5), currentTime(6));

t0  = cputime;   
sum( x );   
t2 = cputime - t0;

currentTime = fix(clock);
fprintf(' Forma 2 - Stop  at %d:%d:%d \n', currentTime(4),...
    currentTime(5), currentTime(6));
%-------------------------------------------------------------------------

fprintf(' Ciclo for: %.4f [seg]  Fun��o soma: %.4f [seg]  \n', t1, t2);



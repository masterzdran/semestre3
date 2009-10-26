%Exercicio 1.c.
%Identifique a funcionalidade da fun��o chirp do MATLAB. Aplique a fun��o
%analysis aos sinais produzidos pela fun��o chirp e explique o formato dos 
%gr�ficos obtidos.

%O sinal chirp corresponde a uma sinus�ide cuja frequencia varia no tempo.
%Vantagem: permite estipular o intervalo de frequencia a trabalhar.
%Desvantagem: N�o deve ser utilizado por m�todos que necessitem de entradas
%de sinal do tipo "ruido branco".

function [] = t1c()
    close all; 
    %recebe um sinal.
    [signal,fs]=t1_nota(2,440,1,pi/4);
    %efectuado um varrimento ao sinal
    t=0:0.001:0.01;
    s_chirp=chirp(t,fs);
    %efectuado a analisys do sinal anterior.
    figure
    analysis(s_chirp,fs);s
    y=s_chirp*signal;
    figure
    analysis(y,fs);
    
    %Gr�ficos Gerados:
    %Gr�fico de Vector:
    %Verifica-se o desempenho do sinal ao longo do tempo.
    %Grafico de Espectro:
    %Grafico de Espectrograma:
    
end

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
    [signal,fs]=t1_nota(1,440,0.005);
    %efectuado um varrimento ao sinal
    t=0:0.001:0.01;
    s_chirp=chirp(t,10);
    %efectuado a analisys do sinal anterior.
    figure
    analysis(s_chirp,0);

    %Gr�ficos Gerados:
    %Gr�fico de Vector:
    %Verifica-se o desempenho do sinal ao longo do tempo.
    %Grafico de Espectro:
    %Grafico de Espectrograma:
    
end

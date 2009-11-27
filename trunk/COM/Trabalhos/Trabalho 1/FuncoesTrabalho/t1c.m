%Exercicio 1.c.
%Identifique a funcionalidade da fun��o chirp do MATLAB. Aplique a fun��o
%analysis aos sinais produzidos pela fun��o chirp e explique o formato dos 
%gr�ficos obtidos.

%O sinal chirp corresponde a uma sinus�ide cuja frequencia varia no tempo.
%Vantagem: permite estipular o intervalo de frequencia a trabalhar.
%Desvantagem: N�o deve ser utilizado por m�todos que necessitem de entradas
%de sinal do tipo "ruido branco".

function t1c()
    close all; 
    %Escollha de uma frequencia de amostragem
    fs=1000;
    %efectuado um varrimento ao sinal em 1 segundo
    t=0:1/fs:1;
    s_chirp=chirp(t,fs);
    %efectuado a analisys do sinal anterior.
    figure
    analysis(s_chirp,fs);
end


% Recorrendo � fun��o awgn do MATLAB, escreva a fun��o tx1 que realize
% um canal de transmiss�o, tal que este some ru�do branco e gaussiano ao 
% sinal de entrada, com rela��o sinal-ru�do especificada como par�metro.
%
function [Y]=tx1(signal,SNR)
    Y=awgn(signal,SNR);
end 
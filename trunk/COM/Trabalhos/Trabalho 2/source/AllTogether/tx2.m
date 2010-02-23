% Modifique a fun��o anterior de forma a que, para al�m da adi��o de 
% ru�do, o canal de transmiss�o realize tamb�m filtragem do tipo 
% passa-baixo com frequ�ncia de corte program�vel (fun��o tx2)

function [Y]=tx2(signal,SNR,FS,Fc)
    freq = ((0:1:length(signal)-1)*FS/(length(signal)))-FS/2;
%     plot(freq,signal);
    signal_F=fftshift(fft(signal));
%     figure;
%     plot(freq,signal_F);
    Filtro=filtroPassaBaixo(freq,Fc);
    signal_F1=signal_F.*Filtro;
%     figure;
%     plot(freq,signal_F1);
    signal=ifft(ifftshift(signal_F1));
%     figure;
%     plot(freq,signal);
	Y=tx1(signal,SNR);
%     figure;
%     plot(freq,Y);
end
% Modifique a fun��o anterior de forma a que, para al�m da adi��o de 
% ru�do, o canal de transmiss�o realize tamb�m filtragem do tipo 
% passa-baixo com frequ�ncia de corte program�vel (fun��o tx2)

function [Y]=tx2(signal,SNR,FS)
    signal_F=fftshift(fft(signal));
    Filtro=filtroPassaBaixo(FS);
    signal=ifft(signal_F.*Filtro);
	Y=tx1(signal,SNR);
end
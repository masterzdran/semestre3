% Modifique a fun��o anterior de forma a que, para al�m da adi��o de 
% ru�do, o canal de transmiss�o realize tamb�m filtragem do tipo 
% passa-baixo com frequ�ncia de corte program�vel (fun��o tx2)

function [Y]=tx2(signal,SNR,FS,Fc)
    signal_F=fftshift(fft(signal));
    Filtro=filtroPassaBaixo(length(signal_F),Fc);
%     [num,den] = fir1(10, FS/Fc,'low' ) ;
%     FilteredOutput = filter(num,den,signal_F); 
    signal=ifft(signal_F.*Filtro);
	Y=tx1(signal,SNR);
end
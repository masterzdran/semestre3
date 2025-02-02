%
%NRZ(bits,Amp,CarrierFreq)
%bits - Sinal Binário de Entrada
%Amp - Amplitude do sinal desejado (0 -> Amp)
%CarrierFreq - Frequencia da Portadora.
%
%Retorno:
%FS - Frequencia de Amostragem, Respeitando o Ritmo de Nyquist
%myX - Sinal de retorno codificado com o NRZ.
function [RB,myX,mynX,TB]=NRZ(signal,Amp,CarrierFreq)
	if(nargin == 0)
		fprintf('� necess�rio mais argumentos.\n');
		return;
	elseif(nargin >3)
		fprintf('T�m argumentos a mais.\n');
		return;
	elseif (nargin == 1)
		fprintf('Assumindo a Amplitude 5 e frequencia da portadora de 100Hz.\n');	
		CarrierFreq=100;
		Amp=5;
	elseif (nargin == 2)
		fprintf('Assumindo a frequencia da portadora de 100Hz.\n');	
		CarrierFreq=100;
	end
		

	%Tempo de Bit do Nosso NRZ
	TB=0.001;

    %Numero de elementos do sinal de entrada
	nbrBits=length(signal);	
	
    %Frequencia Fundamental de Sa�da, respeitando o Ritmo de Nyquist
	RB=2.2*(1/TB);
    if (RB > CarrierFreq)
        fprintf('A frequencia da portadora � inferior � frequencia de amostragem do sinal amostrado. N�o vai ser poss�vel reconstruir com exactid�o o sinal.\n'); 
    end

    %Numero de elementos da nossa Base tempo.
	n=0:1/(nbrBits*RB-1):1;

    %Nosso conjunto que vai conter o sinal de saída
	myX= 1:RB*nbrBits;
	mynX= 1:RB*nbrBits;
	
    %Ciclo que vai criar a onda quadrada
    j=1;
	for i=1:nbrBits
		for  k=1:RB
			if( signal(i) == 1)
				myX(j)=Amp;
				mynX(j)=0;
			else
 				myX(j)=0;
 				mynX(j)=Amp;
            end
            j=j+1;
		end
    end

%     figure;
%     plot(n,myX);
%     title('Sinal ap�s condifica��o NRZ');

end
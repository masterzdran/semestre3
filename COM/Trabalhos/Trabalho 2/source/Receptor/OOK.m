function [RS,mySignal,TB]= OOK(signal,paramA,paramB,fo)
	if(nargin == 0)
		fprintf('� necess�rio mais argumentos.\n');
		return;
	elseif(nargin >4)
		fprintf('T�m argumentos a mais.\n');
		return;
	elseif (nargin == 1)
		fprintf('Assumindo o valor 1 do paramA e o valor 0 no paramB.\n');	
		paramA=1;
	end
		paramB=0;
	
	 [RS,mySignal,TB]=codificador(signal,paramA,paramB,fo);
     figure;
     plot(1/RS,mySignal);
     title('Sinal ap�s condifica��o NRZ');
end
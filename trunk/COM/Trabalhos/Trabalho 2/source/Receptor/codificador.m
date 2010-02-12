function [RS,mySignal,TB] = codificador(signal,A,B,fo)
	if(nargin == 0)
		printf('� necess�rio mais argumentos.\n');
		return;
	elseif(nargin >4)
		printf('T�m argumentos a mais.\n');
		return;
	end
	
	Amp=5;
	[RS,Xt,nXt,TB]=NRZ(signal,Amp,fo);
	x1T = modula(Xt,A,fo,RS);
	x2T = modula(nXt,B,fo,RS);
	mySignal=x1T + x2T;
end
function [FS,mySignal,t] = codificador(signal,A,B,Fo)
	if(nargin == 0)
		printf('� necess�rio mais argumentos.\n');
		return;
	elseif(nargin >4)
		printf('T�m argumentos a mais.\n');
		return;
	end
	
	[TB,Amp]=NRZValues();
	[FS,Xt,nXt,n]=NRZ(signal,Amp,TB,Fo);
    t=n;
	mySignal=modulaQAM(Xt,nXt,Fo,t);
end
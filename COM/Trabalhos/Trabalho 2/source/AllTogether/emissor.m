function [yF,FS,TB]= emissor(signal,Fo,Mod)
    
    if (strcmpi(Mod,'OOK'))
        %Modela��o OOK
        [FS,Signal,TB]=OOK(signal,5,0,Fo);
    elseif(strcmpi(Mod,'PSK'))
        %Modela��o PSK
        [FS,Signal,TB]=PSK(signal,5,-5,Fo);
    else
        fprintf('Modula��o indicada � �nv�lida.\n');
        return;
    end
    aT=cos(2*pi*Fo*TB);
    yT=aT.*Signal;
    yF=fft(yT);
end
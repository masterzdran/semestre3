function [yF,FS,TB]= emissor(signal,Fo,Mod)
    
    if (strcmpi(Mod,'OOK'))
        %Modela��o OOK
        [FS,Signal,TB]=OOK(signal,1,0,Fo);
    elseif(strcmpi(Mod,'PSK'))
        %Modela��o PSK
        [FS,Signal,TB]=PSK(signal,1,-1,Fo);
    else
        fprintf('Modula��o indicada � �nv�lida.\n');
        return;
    end

    aT=Portadora(10000);

    yT=aT.*Signal;
%    figure('name','Sinal yT � Saida do Emissor');
%    my_analysis(yT,FS); 

    yF=fft(yT);
end
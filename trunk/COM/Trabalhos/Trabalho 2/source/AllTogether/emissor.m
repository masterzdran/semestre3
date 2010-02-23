function [Signal,FS]= emissor(signal,Fo,Mod)
    
    if (strcmpi(Mod,'OOK'))
        %Modela��o OOK
        [Signal,FS]=OOK(signal,1,0,Fo);
    elseif(strcmpi(Mod,'PSK'))
        %Modela��o PSK
        [Signal,FS]=PSK(signal,1,-1,Fo);
    else
        fprintf('Modula��o indicada � �nv�lida.\n');
        return;
    end
end
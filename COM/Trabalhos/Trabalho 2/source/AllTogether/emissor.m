function [Signal,FS]= emissor(signal,Fo,Mod)
    
    if (strcmpi(Mod,'OOK'))
        %Modela��o OOK
        [Signal,FS]=OOK(signal,5,0,Fo);
    elseif(strcmpi(Mod,'PSK'))
        %Modela��o PSK
        [Signal,FS]=PSK(signal,5,-5,Fo);
    else
        fprintf('Modula��o indicada � �nv�lida.\n');
        return;
    end
end
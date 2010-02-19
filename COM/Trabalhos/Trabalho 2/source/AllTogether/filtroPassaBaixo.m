% Cria um vector que serve como filtro passa baixo como frequencia de corte
% fs.

function [Filtro] = filtroPassaBaixo(fs,fc)

    Filtro=1:fc/fs:fc;
    rightLimit=floor(fc/2);
    for i=1:length(Filtro)
        if (i>rightLimit )
            Filtro(i)=0;
        else
            Filtro(i)=1;
        end
    end
%     n=fc/2;
%     Filtro=[ones(1,n-fs) 0.5 zeros(1,fs-1)];
end

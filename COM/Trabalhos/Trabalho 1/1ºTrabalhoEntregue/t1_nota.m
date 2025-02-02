%Gera��o de Nota Musical.
%
%Input:
%   a=  Amplitude
%   fs= Frequencia de Amostragem
%   ph= Fase
%
%Output:
%   nota: retorna a respectiva nota.
%   fs: retorna a frequencia de amostragem
%
function [nota,fs] = t1_nota(a,fo,sec,ph)
    %Help Source:
    %http://www.vaughns-1-pagers.com/music/musical-note-frequencies.htm
    %http://en.wikipedia.org/wiki/Piano_acoustics
    %http://www.members.tripod.com/caraipora/esc_temp_freq_.htm
    if (nargin ~= 4)
        if (nargin == 3)
            ph=0;
        else    
            fprintf('Numero de argumentos inv�lido.\n');
            help t1_notas;
            return;
        end
    end
    %Frequencia de Amostragem (em Hz), taxa equivalente do sinal de telefone
    if (fo>2048)
        fs=100.1*fo;
    else
        %fs=4096;
        fs=1000.1*fo;
    end

    n=1:1:fs*sec;
    W=2*pi*(fo/fs);
    %sinal a ser gerado
    if (fi == 0)
        nota=zeros(1, round((fs*sec)/100));
    else
        nota=a*cos(W * n  + ph);
    end
end

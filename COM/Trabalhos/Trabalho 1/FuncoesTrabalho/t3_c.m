function []=t3_c(xt)
%De forma a que possamos recuperar o valor de x(t) o nosso receptor (H(t))
%tem que suportar o mesmo protocolo de recupera��o (a(t)) que foi utilizado
%para a implementa��o.
    %Frequencia fundamental entre a(t) e x(t) � de 2000Hz, uma vez que esta
    %frequencia � o minimo divisor comum entre a fequencia de a(t) e de
    %x(t).
    fo=2000;
    
    %Para respeitar o ritmo de Nyquist, a frequ�ncia de amostragem � maior
    %que duas vezes o valor da frequencia fundamental.
    FS=2.1*fo;
    To=1/fo;
    
    
    t=0:1/(FS-1):1;
    
    
    %Express�es obtidas pelo enunciado.
    a=cos(2*pi*10000*t);
    zt=a.*xt;
    zf=fft(zt);
    
     % y*H =x <=>a*x*H = x <=> H = 1/a
     %Aplicando um filtro passa-baixo com largura de FS do sinal, �
     %possivel recuperar o sinal x(t).
     y=sinc(fs);
     yt=ifft(y);
     yf=fft(y);
     
     


end
%Frequencia de amostragem > 2 *  Frequencia do sinal.
function []=t3_b()
    %Frequencia fundamental entre a(t) e x(t) � de 2000Hz, uma vez que esta
    %frequencia � o minimo divisor comum entre a fequencia de a(t) e de
    %x(t).
    fo=2000;
    
    %Para respeitar o ritmo de Nyquist, a frequ�ncia de amostragem � maior
    %que duas vezes o valor da frequencia fundamental.
    FS=2.1*fo;
    To=1/fo;
    
    
    t=1:1/FS:1;
    
    
    %Express�es obtidas pelo enunciado.
    a=cos(2*pi*10000*t);
    x=1 + cos(2*pi*2000*t);
    
    %Express�o obtida pelo diagrama de blocos do Emissor:
    y=x'*a;
    
    
    
    %Esbo�o do Espectro
    figure;
    plot(x'*a);
    figure;
    plot(x*a');
    figure; my_analysis(x'*a,FS);
    figure; my_analysis(x*a',FS);
end
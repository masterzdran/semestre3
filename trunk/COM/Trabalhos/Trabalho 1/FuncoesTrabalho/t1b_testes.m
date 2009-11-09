%Exercicio 1.b.
%Efectue testes que permitam aferir a sensibilidade do sistema auditivo humano � varia��o na amplitude,
%frequ�ncia e fase da sinus�ide. Escolha um valor adequado para a frequ�ncia de amostragem Fs. Apresente
%os resultados desses testes e comente-os.
%http://www.audicaocritica.com.br/o-que-e/211-equalizador-de-fase-linear.ht
%ml
%Input:
%Output:
function [] = t1b_testes()
    %Amplitude:
    %varia��o de amplitude faz variar o volume do sinal audivel. maior
    %amplitude, som mais alto, menor amplitude som mais baixo.
    %Frequencia:
    %Quanto maior a frequencia mais r�pido o som  se torna mais agudo, quanto menor, mais
    %lento, som mais grave.
    %Fase:
    %
    A_test=1;
    frq_test=263.61;
    sec=1;
    ph=0;
    %Teste de Amplitude
    fprintf('Teste de Amplitude.\n');
    for A=1:5
        t1_nota(A,frq_test,sec,ph);
    end
    pause(2);
    fprintf('Teste de Frequencia.\n');
    %Teste de Frequencia
    for frq_test=1:12
        t1_nota(A_test,440*power(2,(frq_test/12)),sec,ph);
    end
    pause(2);
    fprintf('Teste de Fase.\n');
    %Teste de Fase
    frq_test=263.61;
    for ph=0:pi/12:2*pi
      t1_nota(A_test,frq_test,sec,ph);  
    end
end
%
% ISEL - Instituto Superior de Engenharia de Lisboa.
%
% LEIC - Licenciatura em Engenharia Informatica e de Computadores.
%
% Comunica��es.
%
% pol_div.m
% Fun��o que calcula o resto da divis�o entre dois polinomios
% de coeficientes bin�rios.
%
% Recebe:
% A  - Coeficientes do polin�mio numerador.
% B  - Coeficientes do polin�mio denominador.
%
% Retorna:
% R  - Resto da Divis�o entre A e B.
%
function R = pol_div(A ,B)

mx = A;
nc = 0;
while (nc <= length(mx))

    nc = nc + 1;

    % Quando encontra o 1 faz a divisao.
    if mx(nc) == 1
        mx(nc:nc+length(B)-1) = xor(mx(nc:nc+length(B)-1),B);
    end

    % Quando percorre ate ao fim de M(x)*2^n sai do ciclo
    if (nc+length(B)-1) >= length(mx)
        break;
    end
end

% Obter o resto da divis�o.
R  = [ mx(length(mx)-length(B)+2:length(mx)) ];
end
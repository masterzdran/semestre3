%
% ISEL - Instituto Superior de Engenharia de Lisboa.
%
% LEIC - Licenciatura em Engenharia Informatica e de Computadores.
%
% Com  - Comunica��es.
%
% image2bit.m
%
% Recebe:   I, matriz com valores inteiros (uint8).
% Retorna:  b, vector com os bits que compoem os elementos da matriz.
%              Este vector � do tipo double (sem optimiza��o!).
%
function  b = image2bit( I )

   [NRows, NCols, NBands] = size(I);
   if 1~=NBands
     fprintf(' Imagem com %d bandas \n', NBands );  
     error( 'Apenas se suportam imagens em n�veis de cinzento ' );
   end   
   
   b = double(reshape( blkproc( I, [1 1], @bitget, 8:-1:1 )',...
        [1 size(I,1)*size(I,2)*8] ));
return;
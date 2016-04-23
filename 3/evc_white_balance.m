%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result] = evc_white_balance(input, white)
% evc_white_balance F�hrt den manuellen Wei�abgleich durch.
%
%   EINGABE
%   input  Bild
%   white  Ein RGB Vektor mit der Farbe, die wei� werden soll
%
%   AUSGABE
%   result  Ergebnis nach dem Wei�abgleich

    result = zeros(size(input));
    result(:,:,1) = input(:,:,1) / max(white(1), 0.00001);
    result(:,:,2) = input(:,:,2) / max(white(2), 0.00001);
    result(:,:,3) = input(:,:,3) / max(white(3), 0.00001);
end

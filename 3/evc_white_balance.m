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

% TODO Catch divison by zero!

    result = zeros(size(input));
    result(:,:,1) = input(:,:,1) / white(1);
    result(:,:,2) = input(:,:,2) / white(2);
    result(:,:,3) = input(:,:,3) / white(3);
end

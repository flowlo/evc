%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result] = evc_white_balance(input, white)
%EVC_WHITE_BALANCE F�hrt den manuellen Wei�abgleich durch.
%
%   EINGABE
%   input ... Bild
%   white ... Ein RGB Vektor mit der Farbe, die wei� werden soll
%   AUSGABE
%   result... Ergebnis nach dem Wei�abgleich

    %NOTE: Die folgende Zeile kann gel�scht werden. Sie verhindert, dass
    %die Funktion, solange sie nicht implementiert wurde, abst�rzt.
    result = input;
    
    %TODO: Berechne den Wei�abgleich mit dem white Wert
    
    %NOTE: Hellere Bildpunkte als dieser, werden anschlie�end Werte > 1 haben.    
    %Die dadurch ben�tigte Normalisierung wird am Ende bei der Kontrastst�rkung
    %gemacht. 
	
	%HINT: Behandle eine m�gliche Division durch 0!
	
end
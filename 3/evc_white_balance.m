%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result] = evc_white_balance(input, white)
%EVC_WHITE_BALANCE Führt den manuellen Weißabgleich durch.
%
%   EINGABE
%   input ... Bild
%   white ... Ein RGB Vektor mit der Farbe, die weiß werden soll
%   AUSGABE
%   result... Ergebnis nach dem Weißabgleich

    %NOTE: Die folgende Zeile kann gelöscht werden. Sie verhindert, dass
    %die Funktion, solange sie nicht implementiert wurde, abstürzt.
    result = input;
    
    %TODO: Berechne den Weißabgleich mit dem white Wert
    
    %NOTE: Hellere Bildpunkte als dieser, werden anschließend Werte > 1 haben.    
    %Die dadurch benötigte Normalisierung wird am Ende bei der Kontraststärkung
    %gemacht. 
	
	%HINT: Behandle eine mögliche Division durch 0!
	
end
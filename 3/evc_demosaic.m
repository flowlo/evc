%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result,fnc_demosaic_pattern,fnc_transform_neutral,fnc_interpolate,fnc_concat] = evc_demosaic(input, asShotNeutral)
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht ver�ndert werden!
    
    fnc_demosaic_pattern    = @(input)                  evc_demosaic_pattern(input);
    fnc_transform_neutral   = @(R,G,B,asShotNeutral)    evc_transform_neutral(R,G,B,asShotNeutral);
    fnc_interpolate         = @(R,G,B)                  evc_interpolate(R,G,B);
    fnc_concat              = @(R,G,B)                  evc_concat(R,G,B);
    
    [R,G,B]  = evc_demosaic_pattern(input);
    [R,G,B]  = evc_transform_neutral(R,G,B,asShotNeutral);
    [R,G,B]  = evc_interpolate(R,G,B);
    result   = evc_concat(R,G,B);
end


function [R,G,B] = evc_demosaic_pattern(input)
%evc_demosaic_pattern extrahiert den Rot-, Gr�n- und Blaukanal aus dem
% Bild(input) und gibt sie in den Variablen R,G,B zur�ck. Dabei werden die
% L�cken in den Kan�len noch nicht gef�llt. 
%
%   EINGABE
%   input...            Das Bayer-Pattern-Bild
%
%   AUSGABE
%   R...                Der Rot-Kanal des Bildes (mit L�cken)
%   G...                Der Gr�n-Kanal des Bildes (mit L�cken)
%   B...                Der Blau-Kanal des Bildes (mit L�cken)

	%HINT: 	Dazu eignet sich gut die "start:skip:end" Selektion.
	%       Finde aufgrund deines Datensatzes das richtige Bayer-Pattern.
	%NOTE: 	Die folgenden drei Zeilen k�nnen gel�scht werden. Sie
	%		verhindern, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    
    R = zeros(size(input));
    G = zeros(size(input));
    B = zeros(size(input));
end

function [R,G,B] = evc_transform_neutral(R,G,B,asShotNeutral)
%evc_transform_neutral passt den Rot-, Gr�n- und Blaukanal an den neutralen
% Wei�wert(asShotNeutral) an. Dazu wird jeder Kanal durch den
% entsprechenden Kanal des Wei�wertes dividiert.
%
%   EINGABE
%   R...                Der Rot-Kanal des Bildes
%   G...                Der Gr�n-Kanal des Bildes
%   B...                Der Blau-Kanal des Bildes
%
%   AUSGABE
%   R...                Der Rot-Kanal des Bildes (angepasst an neutralen Wei�wert)
%   G...                Der Gr�n-Kanal des Bildes (angepasst an neutralen Wei�wert)
%   B...                Der Blau-Kanal des Bildes (angepasst an neutralen Wei�wert)

	%NOTE: 	Die folgenden drei Zeilen k�nnen gel�scht werden. Sie
	%		verhindern, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.

    R = zeros(size(R));
    G = zeros(size(G));
    B = zeros(size(B));
end

function [R,G,B] = evc_interpolate(R,G,B)
%evc_interpolate interpoliert den Rot-, Gr�n- und Blaukanal so, dass die
% L�cken ausgef�llt werden.
%
%   EINGABE
%   R...                Der Rot-Kanal des Bildes
%   G...                Der Gr�n-Kanal des Bildes
%   B...                Der Blau-Kanal des Bildes
%
%   AUSGABE
%   R...                Der Rot-Kanal des Bildes (ohne L�cken)
%   G...                Der Gr�n-Kanal des Bildes (ohne L�cken)
%   B...                Der Blau-Kanal des Bildes (ohne L�cken)

	%HINT: 	Die Funktion imfilter kann helfen.
	%NOTE: 	Die folgenden drei Zeilen k�nnen gel�scht werden. Sie
	%		verhindern, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.

    R = zeros(size(R));
    G = zeros(size(G));
    B = zeros(size(B));
end

function [result] = evc_concat(R,G,B)
%evc_interpolate verbindet den Rot-, Gr�n- und Blaukanal zu einem
% Bild.
%
%   EINGABE
%   R...                Der Rot-Kanal des Bildes
%   G...                Der Gr�n-Kanal des Bildes
%   B...                Der Blau-Kanal des Bildes
%
%   AUSGABE
%   result...           Das Bild

	%HINT: 	Die Funktion cat kann helfen.
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.

    result = zeros([size(R,1),size(R,2),3]);
end
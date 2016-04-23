%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result,fnc_demosaic_pattern,fnc_transform_neutral,fnc_interpolate,fnc_concat] = evc_demosaic(input, asShotNeutral)
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht verändert werden!
    
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
%evc_demosaic_pattern extrahiert den Rot-, Grün- und Blaukanal aus dem
% Bild(input) und gibt sie in den Variablen R,G,B zurück. Dabei werden die
% Lücken in den Kanälen noch nicht gefüllt. 
%
%   EINGABE
%   input...            Das Bayer-Pattern-Bild
%
%   AUSGABE
%   R...                Der Rot-Kanal des Bildes (mit Lücken)
%   G...                Der Grün-Kanal des Bildes (mit Lücken)
%   B...                Der Blau-Kanal des Bildes (mit Lücken)

	%HINT: 	Dazu eignet sich gut die "start:skip:end" Selektion.
	%       Finde aufgrund deines Datensatzes das richtige Bayer-Pattern.
	%NOTE: 	Die folgenden drei Zeilen können gelöscht werden. Sie
	%		verhindern, dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
	%TODO:  Implementiere diese Funktion.
    
    R = zeros(size(input));
    G = zeros(size(input));
    B = zeros(size(input));
end

function [R,G,B] = evc_transform_neutral(R,G,B,asShotNeutral)
%evc_transform_neutral passt den Rot-, Grün- und Blaukanal an den neutralen
% Weißwert(asShotNeutral) an. Dazu wird jeder Kanal durch den
% entsprechenden Kanal des Weißwertes dividiert.
%
%   EINGABE
%   R...                Der Rot-Kanal des Bildes
%   G...                Der Grün-Kanal des Bildes
%   B...                Der Blau-Kanal des Bildes
%
%   AUSGABE
%   R...                Der Rot-Kanal des Bildes (angepasst an neutralen Weißwert)
%   G...                Der Grün-Kanal des Bildes (angepasst an neutralen Weißwert)
%   B...                Der Blau-Kanal des Bildes (angepasst an neutralen Weißwert)

	%NOTE: 	Die folgenden drei Zeilen können gelöscht werden. Sie
	%		verhindern, dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
	%TODO:  Implementiere diese Funktion.

    R = zeros(size(R));
    G = zeros(size(G));
    B = zeros(size(B));
end

function [R,G,B] = evc_interpolate(R,G,B)
%evc_interpolate interpoliert den Rot-, Grün- und Blaukanal so, dass die
% Lücken ausgefüllt werden.
%
%   EINGABE
%   R...                Der Rot-Kanal des Bildes
%   G...                Der Grün-Kanal des Bildes
%   B...                Der Blau-Kanal des Bildes
%
%   AUSGABE
%   R...                Der Rot-Kanal des Bildes (ohne Lücken)
%   G...                Der Grün-Kanal des Bildes (ohne Lücken)
%   B...                Der Blau-Kanal des Bildes (ohne Lücken)

	%HINT: 	Die Funktion imfilter kann helfen.
	%NOTE: 	Die folgenden drei Zeilen können gelöscht werden. Sie
	%		verhindern, dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
	%TODO:  Implementiere diese Funktion.

    R = zeros(size(R));
    G = zeros(size(G));
    B = zeros(size(B));
end

function [result] = evc_concat(R,G,B)
%evc_interpolate verbindet den Rot-, Grün- und Blaukanal zu einem
% Bild.
%
%   EINGABE
%   R...                Der Rot-Kanal des Bildes
%   G...                Der Grün-Kanal des Bildes
%   B...                Der Blau-Kanal des Bildes
%
%   AUSGABE
%   result...           Das Bild

	%HINT: 	Die Funktion cat kann helfen.
	%NOTE: 	Die folgende Zeile kann gelöscht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
	%TODO:  Implementiere diese Funktion.

    result = zeros([size(R,1),size(R,2),3]);
end
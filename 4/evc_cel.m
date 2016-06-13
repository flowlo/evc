%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result, fnc_compute_brightness, fnc_compute_chromaticity, fnc_pow_brightness, fnc_transform_brightness, fnc_recompute_color, fnc_fix_NaNs_and_Inf] = evc_cel(color, intervals, exponent)
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht ver�ndert werden!
    
    fnc_compute_brightness      = @(input)                      evc_compute_brightness(input);
    fnc_compute_chromaticity    = @(input, brightness)          evc_compute_chromaticity(input, brightness);
    fnc_pow_brightness          = @(brightness, exponent)       evc_pow_brightness(brightness, exponent);
    fnc_transform_brightness    = @(brightness, intervals)      evc_transform_brightness(brightness, intervals);
    fnc_recompute_color         = @(chromaticity, brightness)   evc_recompute_color(chromaticity, brightness);
    fnc_fix_NaNs_and_Inf        = @(input)                      evc_fix_NaNs_and_Inf(input);    
    
    [brightnessLinear]          = evc_compute_brightness(color);    
    [chromaticity]              = evc_compute_chromaticity(color, brightnessLinear);
    [brightnessExp]             = evc_pow_brightness(brightnessLinear, exponent);    
    [brightnessTransformed]     = evc_transform_brightness(brightnessExp, intervals);    
    [brightnessTransformedExp]  = evc_pow_brightness(brightnessTransformed, 1/exponent);    
    [celShaded]                 = evc_recompute_color(chromaticity, brightnessTransformedExp);    
    [result]                    = evc_fix_NaNs_and_Inf(celShaded);

end


function [brightnessLinear] = evc_compute_brightness(input)
%evc_compute_brightness berechnet die Helligkeit pro Pixel. Zur Berechnung
% der Helligkeit wird folgende Formel verwendet: 
% R*0.2989 + G*0.5870 + B*0.1140
%
%   EINGABE
%   input...            Ein RGB-Bild
%
%   AUSGABE
%   brightnessLinear... Ein Einkanal-Bild mit dem Helligkeitswert jedes
%                       Pixels.

	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    brightnessLinear = zeros(size(input,1), size(input,2));
end

function [chromaticity] = evc_compute_chromaticity(input, brightnessLinear)
%evc_compute_chromaticity Berechnet die Chromatizit�t des Bildes. Dies
% passiert, indem die Farbe des Bildes durch die Helligkeit dividiert wird.
%
%   EINGABE
%   input...            Ein RGB-Bild
%   brightnessLinear... Ein Einkanal-Bild mit der Helligkeit jedes Pixels
%                       in input.
%
%   AUSGABE
%   chromaticity...     Ein RGB-Bild mit der Chromatizi�t pro Pixel.

	%HINT: 	input hat 3 Kan�le und brightnessLinear nur einen.
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    chromaticity = input;
end

function [brightnessTransformed] = evc_transform_brightness(brightness, intervals)
%evc_transform_brightness diskretisiert die Helligkeit. Dazu wird der
% Wertebereich zwischen 0 und 1 in N gleich gro�e Intervalle eingeteilt.
% Jedes Intervall wird dann auf einen konkreten Wert abgebildet. Dabei wird
% das niedrigste Intervall auf 0, das h�chste auf 1, und alle anderen
% gleichm��ig zwischen 0 und 1 abgebildet.
%
%   EINGABE
%   brightness...               Ein Einkanal-Bild mit der Helligkeit pro Pixel
%   intervals...                Die Anzahl der Intervalle (=N)
%
%   AUSGABE
%   brightnessTransformed...    Das diskretisierte Helligkeitsbild.

	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    brightnessTransformed = brightness;
end

function [result] = evc_recompute_color(chromaticity, brightnessLinear)
%evc_recompute_color berechnet den neuen Farbwert des Pixels aus der
% Chromatizit�t und der Helligkeit. Dazu wird die Chromatizit�t und die
% Helligkeit mitinander multipliziert. 
%
%   EINGABE
%   chromaticity...     Die Chromatizit�t pro Pixel (als 3-Kanal-Bild)
%   brightnessLinear... Die Helligkeit pro Pixel (als 1-Kanal-Bild)
%
%   AUSGABE
%   result...           Ein RGB-Bild mit dem neuen Farbwert pro Pixel

	%HINT: 	chromaticity hat 3 Kan�le und brightnessLinear nur einen.
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    result = chromaticity;
end

function [result] = evc_fix_NaNs_and_Inf(input)
%evc_fix_NaNs_and_Inf setzt alle NaNs und Infs auf 0.
%
%   EINGABE
%   input...            Ein RGB-Bild
%
%   AUSGABE
%   result...           Ein RGB-Bild ohne NaNs und Infs

	%HINT: 	Hilfreiche Funktionen: isnan, isinf
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    result = input;
end


function [brightnessExp] = evc_pow_brightness(brightness, exponent)
%evc_pow_brightness verschiebt die Helligkeit in einen bzw aus einem
% logarithmischen Raum. Dazu muss der Helligkeitswert einfach mit dem
% Exponenten potenziert werden. 
%
%   EINGABE
%   brightness...       Ein Einkanal-Bild mit dem Helligkeitswert pro Pixel
%   exponent...         Der Exponent
%
%   AUSGABE
%   brightnessExp...    Ein Einkanal-Bild mit dem Helligkeitswert pro Pixel
%                       im logarithmischen Raum

	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    brightnessExp = brightness;
end
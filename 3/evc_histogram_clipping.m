%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result, fnc_prep_histogram, fnc_tranform_histogram, fnc_clip_histogram] = evc_histogram_clipping(input, low, high)
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht ver�ndert werden!

	fnc_prep_histogram = @(input, low, hight) evc_prepare_histogram_range(input, low, high);
	fnc_tranform_histogram = @(input, newLow, newHigh) evc_transform_histogram(input, newLow, newHigh);
	fnc_clip_histogram = @(input) evc_clip_histogram(input);
	
	[newLow, newHigh] = evc_prepare_histogram_range(input, low, high);
	result            = evc_transform_histogram(input, newLow, newHigh);
	result            = evc_clip_histogram(result);
end

function [newLow, newHigh] = evc_prepare_histogram_range(input, low, high)
% evc_prepare_histogram_range bestimmt zun�chst die f�r das Normalisieren
% notwendige obere  und untere Schranke, die bei der Normalisierung auf
% [0,1] abgebildet werden sollen.
% Falls low < 0 ist, muss es auf 0 gesetzt werden.
% Falls high > als die maximalen Intensit�t des Bildes ist, muss
% es auf die maximale Intensit�t gesetzt werden.
%
%   EINGABE
%   input    Bild
%   low      Aktueller Schwarzpunkt
%   high     Aktueller Wei�punkt

%   AUSGABE	
%   newLow   Neuer Schwarzpunkt
%   newHigh  Neuer Wei�punkt

    newLow = low;
    newLow(newLow < 0) = 0;

    maxIntensity = max(input(:));

    newHigh = high;
    newHigh(newHigh > maxIntensity) = maxIntensity;
end

function [result] = evc_transform_histogram(input, newLow, newHigh)
% evc_transform_histogram f�hrt die Histogram-Normalisierung durch und 
% bildet das Intervall [newLow, newHigh] auf [0, 1] ab.
%
%   EINGABE
%   input    Bild
%   newLow   Schwarzpunkt
%   newHigh  Wei�punkt

%   AUSGABE	
%   result   Das Bild nach der Histogram-Normalisierung

    result = (input - newLow) / (newHigh - newLow);
end

function [result] = evc_clip_histogram(img)
% evc_clip_histogram setzt alle Werte die nach der Transformation
% des Histogramms noch < 0 sind auf 0 und Werte die > 1 sind, auf 1.
%
%   EINGABE
%   img     Das Bild nach der Histogram-Normalisierung

%   AUSGABE	
%   result  Das Bild nach der Clipping-Operation

    result = img;
    result(result < 0) = 0;
    result(result > 1) = 1;
end

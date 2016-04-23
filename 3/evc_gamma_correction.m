%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result, fnc_compute_brightness, fnc_compute_chromaticity, fnc_gamma_correct, fnc_reconstruct] = evc_gamma_correction(input, gamma, saturate)
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht verändert werden!
    
    fnc_compute_brightness      = @(input) evc_compute_brightness(input);
    fnc_compute_chromaticity    = @(input, brightness) evc_compute_chromaticity(input, brightness);
    fnc_gamma_correct           = @(input, gamma) evc_gamma_correct(input, gamma);
    fnc_reconstruct             = @(corrected_brightness, chromaticity) evc_reconstruct(corrected_brightness, chromaticity);    
    
    if (saturate)
        brightness              = evc_compute_brightness(input);
        chromaticity            = evc_compute_chromaticity(input, brightness);
        brightness_gamma        = evc_gamma_correct(brightness, gamma);
        result                  = evc_reconstruct(brightness_gamma, chromaticity);
    else            
        result                  = evc_gamma_correct(input, gamma);
    end
end

function [brightness] = evc_compute_brightness(input)
%evc_compute_brightness berechnet die Helligkeitswerte des Bildes input, 
% das mit dem Kehrwert des maximalen Wertes der Farbkanäle normalisiert 
% wurde. Anschließend wird das Result wiederum mit dem maximalen Wert
% multipliziert.
%
%   EINGABE
%   input...        Bild

%   AUSGABE
%   brightness...   Helligkeitswerte des Bildes

    %NOTE: 	Die folgende Zeile kann gelöscht werden. Sie verhindert, 
    %       dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
    %TODO:  Implementiere diese Funktion.

    brightness = rgb2gray(input);
end

function [chromaticity] = evc_compute_chromaticity(input, brightness)
%evc_compute_chromaticity berechnet die Chromatizität des Bildes input
% mithilfe dessen Helligkeitswerte in brightness. Dabei werden die
% Farbkanäle des Inputbildes durch die Helligkeit dividiert.
%
%   EINGABE
%   input...            Bild
%   brightness...       Helligkeitswerte

%   AUSGABE
%   chromaticity...     Chromatizität des Bildes

    %NOTE: 	Die folgende Zeile kann gelöscht werden. Sie verhindert, 
    %       dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
    %TODO:  Implementiere diese Funktion.
    
    chromaticity = input;
end

function [corrected] = evc_gamma_correct(input, gamma)
%evc_gamma_correct führt die Gammakorrektur auf das gegebene Bild input
% aus. Dies wird durch einfaches Potenzieren mit dem Kehrtwert von Gamma
% (gamma^-1) erreicht.
%
%   EINGABE
%   input...        Bild
%   gamma...        Gamma Wert

%   AUSGABE
%   corrected...    Gamma-korrigiertes Bild

    %HINT:  Behandle eine mögliche Division durch 0!
    %NOTE: 	Die folgende Zeile kann gelöscht werden. Sie verhindert, 
    %       dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
    %TODO:  Implementiere diese Funktion.
    
    corrected = input;
end

function [result] = evc_reconstruct(brightness_gamma, chromaticity)
%evc_reconstruct rekonstruiert die Farbwerte durch Multiplikation der
% korrigierten Helligkeitswerte mit der Chromatizität.
%
%   EINGABE
%   brightness_gamma...     Gamma-korrigierte Helligkeitswerte
%   chromaticity...         Chromatizität

%   AUSGABE
%   result...               Rekonstruiertes Bild

    %NOTE: 	Die folgende Zeile kann gelöscht werden. Sie verhindert, 
    %       dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
    %TODO:  Implementiere diese Funktion.
    
    result = brightness_gamma;
end

function [result, fnc_compute_brightness, fnc_compute_chromaticity, fnc_pow_brightness, fnc_transform_brightness, fnc_recompute_color, fnc_fix_NaNs_and_Inf] = evc_cel(color, intervals, exponent)
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
% evc_compute_brightness berechnet die Helligkeit pro Pixel. Zur Berechnung der
% Helligkeit wird folgende Formel verwendet: R*0.2989 + G*0.5870 + B*0.1140
%
%   EINGABE
%   input             Ein RGB-Bild.
%
%   AUSGABE
%   brightnessLinear  Ein Einkanal-Bild mit dem Helligkeitswert jedes Pixels.

    brightnessLinear = input(:, :, 1) * 0.2989 + input(:, :, 2) * 0.5870 + input(:, :, 3) * 0.1140;
end

function [chromaticity] = evc_compute_chromaticity(input, brightnessLinear)
% evc_compute_chromaticity Berechnet die Chromatizitaet des Bildes. Dies
% passiert, indem die Farbe des Bildes durch die Helligkeit dividiert wird.
%
%   EINGABE
%   input             Ein RGB-Bild
%   brightnessLinear  Ein Einkanal-Bild mit der Helligkeit jedes Pixels
%                     in input.
%
%   AUSGABE
%   chromaticity      Ein RGB-Bild mit der Chromatiziaet pro Pixel.

    chromaticity = input ./ repmat(brightnessLinear, [1 1 3]);
end

function [brightnessTransformed] = evc_transform_brightness(brightness, intervals)
% evc_transform_brightness diskretisiert die Helligkeit. Dazu wird der
% Wertebereich zwischen 0 und 1 in N gleich grosse Intervalle eingeteilt.
% Jedes Intervall wird dann auf einen konkreten Wert abgebildet. Dabei wird
% das niedrigste Intervall auf 0, das hoechste auf 1, und alle anderen
% gleichmaessig zwischen 0 und 1 abgebildet.
%
%   EINGABE
%   brightness             Ein Einkanal-Bild mit der Helligkeit pro Pixel
%   intervals              Die Anzahl der Intervalle (=N)
%
%   AUSGABE
%   brightnessTransformed  Das diskretisierte Helligkeitsbild.

    % WolframAlpha: plot n = 4, f(x) = floor(x * n) / (n - 1) from x = 0 to x = 1
    brightnessTransformed = floor(brightness * intervals) / (intervals - 1);
end

function [result] = evc_recompute_color(chromaticity, brightnessLinear)
% evc_recompute_color berechnet den neuen Farbwert des Pixels aus der
% Chromatizitaet und der Helligkeit. Dazu wird die Chromatizitaet und die
% Helligkeit mitinander multipliziert. 
%
%   EINGABE
%   chromaticity      Die Chromatizitaet pro Pixel (als 3-Kanal-Bild)
%   brightnessLinear  Die Helligkeit pro Pixel (als 1-Kanal-Bild)
%
%   AUSGABE
%   result            Ein RGB-Bild mit dem neuen Farbwert pro Pixel

    % HINT: chromaticity hat 3 Kanaele und brightnessLinear nur einen.
    result = chromaticity .* repmat(brightnessLinear, [1 1 3]);
end

function [result] = evc_fix_NaNs_and_Inf(input)
% evc_fix_NaNs_and_Inf setzt alle NaNs und Infs auf 0.
%
%   EINGABE
%   input  Ein RGB-Bild
%
%   AUSGABE
%   result  Ein RGB-Bild ohne NaNs und Infs

    result = input;
    result(isnan(result)) = 0;
    result(isinf(result)) = 0;
end

function [brightnessExp] = evc_pow_brightness(brightness, exponent)
% evc_pow_brightness verschiebt die Helligkeit in einen bzw aus einem
% logarithmischen Raum. Dazu muss der Helligkeitswert einfach mit dem
% Exponenten potenziert werden. 
%
%   EINGABE
%   brightness     Ein Einkanal-Bild mit dem Helligkeitswert pro Pixel
%   exponent       Der Exponent
%
%   AUSGABE
%   brightnessExp  Ein Einkanal-Bild mit dem Helligkeitswert pro Pixel
%                  im logarithmischen Raum

    brightnessExp = brightness .^ exponent;
end

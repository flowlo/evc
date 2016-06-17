function [ result, fPx ] = evc_compute_depth( D, fMm, B, ps)
% evc_compute_depth Wandelt die Disparitaeten anhand der bekannten
% Kameraparameter in "echte" Tiefenwerte in mm um.
%
%   EINGABE
%   D       Ein Einkanal-Bild mit den Disparitaeten jedes Pixels
%           in Pixel-Dimensionen
%   fMm     Fokale Laenge der Kameras in mm
%   B       Basis in mm
%   ps      Groesse (Kantenlaennge) eines Pixels in mm
%
%   AUSGABE
%   result  Ein Einkanal-Bild mit dem Tiefenwert jedes
%           Pixels.
%   fPx     Die fokale Laenge in Pixel

    % Wandle fMm von mm in Pixel-Dimensionen um
    fPx = fMm / ps;

    % Berechne die Tiefenwerte anhand der bekannten Formel aus fPx, B und D.
    result = (fPx * B) ./ D;
end


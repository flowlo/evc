function [N, fnc] = evc_compute_normals( Z, V )
    fnc.compute_position                = @(Z, V)          evc_compute_position(Z, V);
    fnc.compute_tangents                = @(D)             evc_compute_tangents(D);
    fnc.compute_unnormalized_normals    = @(dX, dY)        evc_compute_unnormalized_normals(dX, dY);
    fnc.normalize_normals               = @(nUnnormalized) evc_normalize_normals(nUnnormalized);

    [ D ]               = evc_compute_position( Z, V );
    [ dX, dY ]          = evc_compute_tangents( D );
    [ nUnnormalized ]   = evc_compute_unnormalized_normals( dX, dY );
    [ N ]               = evc_normalize_normals( nUnnormalized );
end

function [ D ] = evc_compute_position( Z, V )
% evc_compute_position projiziert die Pixel in den View-Space.
% Dies erreicht man, indem man die Blickrichtung mit den
% Tiefenwerten multipliziert. Man erhält ein Bild D in dem jedes
% Pixel die Position im View-Space repräsentiert. 
%
%   EINGABE
%   Z  Ein Einkanal-Bild mit den Tiefenwerten im Viewing-
%      Koordinatensystem.
%   V  Ein Dreikanal-Bild mit der normalisierten
%      Blickrichtung in Richtung des Pixels
%
%   AUSGABE
%   D  Ein Dreikanal-Bild mit der Position im View-Space

    D = V .* repmat(Z, [1,1,3]);
end

function [ dX, dY ] = evc_compute_tangents( D )
% evc_compute_tangents Berechnet zwei Tangentenbilder (dX, dY). Dies wird
% gemacht, indem der Vorwärts-, Rueckwärts- oder der zentrale
% Differenzenquotient von D gebildet wird. 
%
%   EINGABE
%   D   Ein Dreikanal-Bild mit der Position im View-Space
%
%   AUSGABE
%   dX  Ein Dreikanal-Bild mit den Tangenten in X-Richtung
%   dY  Ein Dreikanal-Bild mit den Tangenten in Y-Richtung

    % Erstelle einen Filter-Kernel fuer jedes Tangentenbild und
    % filtere damit D um das entsprechende Tangentenbild zu erhalten.
    % HINT: Siehe Kapitel 03 der Uebungseinfuehrung "Transformationen und Filter"
    dX = imfilter(D, [-1,  1]);
    dY = imfilter(D, [ 1; -1]);
end

function [ nUnnormalized ] = evc_compute_unnormalized_normals( dX, dY )
% evc_compute_unnormalized_normals Berechnet ein
% Normalen-Bild anhand der Tangentenbilder.
%
%   EINGABE
%   dX             Ein Dreikanal-Bild mit den Tangenten in X-Richtung
%   dY             Ein Dreikanal-Bild mit den Tangenten in Y-Richtung
%
%   AUSGABE
%   nUnnormalized  Ein Dreikanal-Bild mit den nicht-normalisierten Normalen

    % Berechne das Kreuzprodukt der Tangenten
    nUnnormalized = cross(dX, dY, 3);
end

function [ N ] = evc_normalize_normals( nUnnormalized )
% evc_normalize_normals Normalisiert die Normalen.
%
%   EINGABE
%   nUnnormalized  Ein Dreikanal-Bild mit den nicht-normalisierten Normalen
%
%   AUSGABE
%   N              Ein Dreikanal-Bild mit den normalisierten Normalen

    N = nUnnormalized ./ repmat(sqrt(dot(nUnnormalized, nUnnormalized, 3)), [1,1,3]);
end

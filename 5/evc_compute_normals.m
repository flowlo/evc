%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.

function [N, fnc] = evc_compute_normals( Z, V )
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht verändert werden!
    
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
%evc_compute_position projiziert die Pixel in den View-Space.
% Dies erreicht man, indem man die Blickrichtung mit den
% Tiefenwerten multipliziert. Man erhält ein Bild D in dem jedes
% Pixel die Position im View-Space repräsentiert. 
%
%   EINGABE
%   Z ...               Ein Einkanal-Bild mit den Tiefenwerten im Viewing-
%                       Koordinatensystem.
%   V ...               Ein Dreikanal-Bild mit der normalisierten 
%                       Blickrichtung in Richtung des Pixels
%
%   AUSGABE
%   D...                Ein Dreikanal-Bild mit der Position im View-Space
    
    % NOTE: Diese Zeile kann gelöscht werden. Sie verhindert, dass
    %       die Funktion abstürzt, solange sie nicht implementiert wurde.
    % TODO: Implementiere diese Funktion
    D = zeros(size(V));
end

function [ dX, dY ] = evc_compute_tangents( D )
%evc_compute_tangents Berechnet zwei Tangentenbilder (dX,dY). Dies wird
% gemacht, indem der Vorwärts-, Rückwärts- oder der zentrale
% Differenzenquotient von D gebildet wird. 
%
%   EINGABE
%   D...                Ein Dreikanal-Bild mit der Position im View-Space
%
%   AUSGABE
%   dX...               Ein Dreikanal-Bild mit den Tangenten in X-Richtung
%   dY...               Ein Dreikanal-Bild mit den Tangenten in Y-Richtung
        
    % NOTE: Diese Zeilen können gelöscht werden. Sie verhindern, dass
    %       die Funktion abstürzt, solange sie nicht implementiert wurde.
    % TODO: Erstelle einen Filter-Kernel für jedes Tangentenbild und
    %       filtere damit D um das entsprechende Tangentenbild zu erhalten.
    % HINT: Siehe Kapitel 03 der Übungseinführung "Transformationen und Filter"
    dX = zeros(size(D));
    dY = zeros(size(D));
end

function [ nUnnormalized ] = evc_compute_unnormalized_normals( dX, dY )
%evc_compute_unnormalized_normals Berechnet ein Normalen-Bild anhand der 
% Tangentenbilder
%
%   EINGABE
%   dX...               Ein Dreikanal-Bild mit den Tangenten in X-Richtung
%   dY...               Ein Dreikanal-Bild mit den Tangenten in Y-Richtung
%
%   AUSGABE
%   nUnnormalized...    Ein Dreikanal-Bild mit den nicht-normalisierten Normalen
        
    % NOTE: Diese Zeile kann gelöscht werden. Sie verhindert, dass
    %       die Funktion abstürzt, solange sie nicht implementiert wurde.
    % TODO: Berechne das Kreuzprodukt der Tangenten
    nUnnormalized = zeros(size(dX));	
end

function [ N ] = evc_normalize_normals( nUnnormalized )
%evc_normalize_normals Normalisiert die Normalen 
%
%   EINGABE
%   nUnnormalized...    Ein Dreikanal-Bild mit den nicht-normalisierten Normalen
%
%   AUSGABE
%   N...                Ein Dreikanal-Bild mit den normalisierten Normalen

    % NOTE: Diese Zeile kann gelöscht werden. Sie verhindert, dass
    %       die Funktion abstürzt, solange sie nicht implementiert wurde.
    % TODO: Implementiere diese Funktion
    N = nUnnormalized;
end
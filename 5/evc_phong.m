%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.

function [result, ambient, diffuse, specular, fnc] = evc_phong( V, L, N, ia, id, is, ka, kd, ks, alpha )
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht verändert werden!
    
    fnc.compute_reflection                = @( L, N )                                         evc_compute_reflection( L, N );
    fnc.compute_lighting                  = @( V, L, N, R, ia, id, is, ka, kd, ks, alpha )    evc_compute_lighting( V, L, N, R, ia, id, is, ka, kd, ks, alpha );
    
    [ R ]                                = evc_compute_reflection( L, N );
    [result, ambient, diffuse, specular] = evc_compute_lighting( V, L, N, R, ia, id, is, ka, kd, ks, alpha );        
end


function [ R ] = evc_compute_reflection( L, N )
%evc_compute_reflection berechnet den normalisierten Reflektions-Vektor für die
% Phong-Beleuchtung
%
%   EINGABE
%   L ...               Ein Dreikanal-Bild mit der normalisierten 
%                       Richtung zur Lichtquelle pro Pixel
%   N ...               Ein Dreikanal-Bild mit der normalisierten 
%                       Normale pro Pixel
%
%   AUSGABE
%   R ...               Ein Dreikanal-Bild mit dem normalisierten 
%                       Reflektions-Vektor pro Pixel
    
    % NOTE: Diese Zeile kann gelöscht werden. Sie verhindert, dass
    %       die Funktion abstürzt, solange sie nicht implementiert wurde.
    % TODO: Implementiere diese Funktion
    R = zeros(size(L));
end

function [result, ambient, diffuse, specular] = evc_compute_lighting( V, L, N, R, ia, id, is, ka, kd, ks, alpha )
%evc_compute_lighting berechnet das Phong-Beleuchtungsmodell (siehe Skriptum).
%
%   EINGABE
%   V ...               Ein Dreikanal-Bild mit der normalisierten 
%                       Blickrichtung pro Pixel
%   L ...               Ein Dreikanal-Bild mit der normalisierten 
%                       Richtung zur Lichtquelle pro Pixel
%   N ...               Ein Dreikanal-Bild mit der normalisierten 
%                       Normale pro Pixel
%   R ...               Ein Dreikanal-Bild mit dem normalisierten 
%                       Reflektions-Vektor pro Pixel
%   ia ...              Farbe der ambienten Beleuchtung (RGB-Vektor)
%   id ...              Farbe der diffusen Beleuchtung (RGB-Vektor)
%   is ...              Farbe der Glanzpunkte (specular Beleuchtung) (RGB-Vektor)
%   ka ...              Konstante für ambiente Beleuchtung
%   kd ...              Konstante für diffuse Beleuchtung
%   ks ...              Konstante für Glanzpunkte (specular Beleuchtung)
%   alpha...            Glanzkonstante
%
%   AUSGABE
%   result...           Ein Dreikanal-Bild mit der beleuchteten Szene
%   ambient...          Ein Dreikanal-Bild mit der ambient-beleuchteten Szene
%   diffuse...          Ein Dreikanal-Bild mit der diffus-beleuchteten Szene
%   specular...         Ein Dreikanal-Bild mit der specular-beleuchteten Szene
    
    % NOTE: Diese Zeilen können gelöscht werden. Sie verhindern, dass
    %       die Funktion abstürzt, solange sie nicht implementiert wurde.
    ambient = zeros(size(V));
    diffuse = zeros(size(V));
    specular = zeros(size(V));
    result = zeros(size(V));
end


function [result, ambient, diffuse, specular, fnc] = evc_phong( V, L, N, ia, id, is, ka, kd, ks, alpha )
    fnc.compute_reflection                = @( L, N )                                         evc_compute_reflection( L, N );
    fnc.compute_lighting                  = @( V, L, N, R, ia, id, is, ka, kd, ks, alpha )    evc_compute_lighting( V, L, N, R, ia, id, is, ka, kd, ks, alpha );

    [ R ]                                 = evc_compute_reflection( L, N );
    [result, ambient, diffuse, specular]  = evc_compute_lighting( V, L, N, R, ia, id, is, ka, kd, ks, alpha );        
end

function [ R ] = evc_compute_reflection( L, N )
% evc_compute_reflection berechnet den normalisierten
% Reflektions-Vektor für die Phong-Beleuchtung
%
%   EINGABE
%   L  Ein Dreikanal-Bild mit der normalisierten Richtung zur Lichtquelle pro Pixel
%   N  Ein Dreikanal-Bild mit der normalisierten Normale pro Pixel
%
%   AUSGABE
%   R  Ein Dreikanal-Bild mit dem normalisierten Reflektions-Vektor pro Pixel

    R = N .* repmat(dot(L, N, 3), [1, 1, 3]) * 2 - L;
end

function [result, ambient, diffuse, specular] = evc_compute_lighting( V, L, N, R, ia, id, is, ka, kd, ks, alpha )
% evc_compute_lighting berechnet das Phong-Beleuchtungsmodell (siehe Skriptum).
%
%   EINGABE
%   V         Ein Dreikanal-Bild mit der normalisierten
%             Blickrichtung pro Pixel
%   L         Ein Dreikanal-Bild mit der normalisierten
%             Richtung zur Lichtquelle pro Pixel
%   N         Ein Dreikanal-Bild mit der normalisierten
%             Normale pro Pixel
%   R         Ein Dreikanal-Bild mit dem normalisierten
%             Reflektions-Vektor pro Pixel
%   ia        Farbe der ambienten Beleuchtung (RGB-Vektor)
%   id        Farbe der diffusen Beleuchtung (RGB-Vektor)
%   is        Farbe der Glanzpunkte (specular Beleuchtung) (RGB-Vektor)
%   ka        Konstante fuer ambiente Beleuchtung
%   kd        Konstante fuer diffuse Beleuchtung
%   ks        Konstante fuer Glanzpunkte (specular Beleuchtung)
%   alpha     Glanzkonstante
%
%   AUSGABE
%   result    Ein Dreikanal-Bild mit der beleuchteten Szene
%   ambient   Ein Dreikanal-Bild mit der ambient-beleuchteten Szene
%   diffuse   Ein Dreikanal-Bild mit der diffus-beleuchteten Szene
%   specular  Ein Dreikanal-Bild mit der specular-beleuchteten Szene
    
    ambient = ka * ia;
    diffuse = (kd * id) .* repmat(dot(L, N, 3), [1, 1, 3]);
    specular = (ks * is) .* repmat(max(0, dot(R, V, 3)).^alpha, [1, 1, 3]);
    result = ambient + diffuse + specular;
    result = specular;
end


%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result] = evc_compute_binary(input, x, top)
% evc_compute_binary Berechnet ein binäres Bild anhand des übergebenen
% Schwellwertes (x).
%
%   EINGABE
%   input   RGB-Bild
%   x       skalarer Schwellwert
%   top     Falls 0, soll ein Inversionsbild generiert werden. Also 0
%           soll 1 und 1 soll 0 werden.
%   AUSGABE
%   result  Binäres RGB-Bild, dass nur 0.0 oder 1.0 enthalten darf. Achtung
%           das Ergebnis muss vom Type double sein! Achte aber darauf
%           dass alle 3 Farbkanäle erhalten bleiben, sprich die Operation
%           auf jeden Farbkanal angewandt wird.
    result = double(input > x);
    
    if top == 0
        result = 1 - result;
    end
end

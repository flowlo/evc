%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [ result, fPx ] = evc_compute_depth( D, fMm, B, ps)
%evc_compute_depth Wandelt die Disparit�ten anhand der bekannten Kameraparameter
% in "echte" Tiefenwerte in mm um.
%
%   EINGABE
%   D ...               Ein Einkanal-Bild mit den Disparit�ten jedes Pixels
%                       in Pixel-Dimensionen
%   fMm ...             Fokale L�nge der Kameras in mm
%   B ...               Basis in mm
%   ps ...              Gr��e (Kantenl�nge) eines Pixels in mm
%
%   AUSGABE
%   result...           Ein Einkanal-Bild mit dem Tiefenwert jedes
%                       Pixels.
%   fPx...              Die fokale L�nge in Pixel

	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
    %TODO:  Wandle fMm von mm in Pixel-Dimensionen um
    fPx = fMm;    
    
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
    %TODO:  Berechne die Tiefenwerte anhand der bekannten Formel aus fPx, B
    %       und D
    result = zeros(size(D));        
end


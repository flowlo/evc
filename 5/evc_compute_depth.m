%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [ result, fPx ] = evc_compute_depth( D, fMm, B, ps)
%evc_compute_depth Wandelt die Disparitäten anhand der bekannten Kameraparameter
% in "echte" Tiefenwerte in mm um.
%
%   EINGABE
%   D ...               Ein Einkanal-Bild mit den Disparitäten jedes Pixels
%                       in Pixel-Dimensionen
%   fMm ...             Fokale Länge der Kameras in mm
%   B ...               Basis in mm
%   ps ...              Größe (Kantenlänge) eines Pixels in mm
%
%   AUSGABE
%   result...           Ein Einkanal-Bild mit dem Tiefenwert jedes
%                       Pixels.
%   fPx...              Die fokale Länge in Pixel

	%NOTE: 	Die folgende Zeile kann gelöscht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
    %TODO:  Wandle fMm von mm in Pixel-Dimensionen um
    fPx = fMm;    
    
	%NOTE: 	Die folgende Zeile kann gelöscht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abstürzt.
    %TODO:  Berechne die Tiefenwerte anhand der bekannten Formel aus fPx, B
    %       und D
    result = zeros(size(D));        
end


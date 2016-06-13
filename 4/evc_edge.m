%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result,fnc_detect_edges,fnc_maximum_edge,fnc_blur_edges,fnc_strengthen_edges,fnc_blend_edges] = evc_edge(color, normals, sigma, edgeColor, edgeStrength)       
% Diese Funktion ist die Hauptfunktion.
% Sie ruft in der richtigen Reihenfolge die zu implementierenden Funktionen auf.
% ACHTUNG: Diese Funktion darf nicht ver�ndert werden!
    
    fnc_detect_edges            = @(normals)                        evc_detect_edges    (normals);
    fnc_maximum_edge            = @(edgesXyz)                       evc_maximum_edge    (edgesXyz);
    fnc_blur_edges              = @(edgesGray,sigma)                evc_blur_edges      (edgesGray,sigma);
    fnc_strengthen_edges        = @(edgesBlurred,edgeStrength)      evc_strengthen_edges(edgesBlurred,edgeStrength);
    fnc_blend_edges             = @(color, edgeColor, edgeFactor)   evc_blend_edges     (color, edgeColor, edgeFactor);
    
    [edgesXyz]      = evc_detect_edges      (normals);
    [edgesGray]     = evc_maximum_edge      (edgesXyz);
    [edgesBlurred]  = evc_blur_edges        (edgesGray,sigma);
    [edgeFactor]    = evc_strengthen_edges  (edgesBlurred,edgeStrength);
    [result]        = evc_blend_edges       (color, edgeColor, edgeFactor);
end

function [edgesXyz] = evc_detect_edges(normals)
%evc_detect_edges erkennt Kanten in einem Normalen-Bild. Dazu wird ein
% Laplace-Filter verwendet, der horizontale, vertikale und diagonale Kanten
% erkennt. Im Anschluss wird der Absolutbetrag vom gefilterten Bild
% berechnet und zur�ckgegeben.
%
%   EINGABE
%   normals...          Ein Normalen-Bild (3-Kanal, mit X,Y,Z als Kan�le)
%
%   AUSGABE
%   edgesXyz...         Ein 3-Kanal-Bild mit der St�rke der Kante pro
%                       Achse, pro Pixel

	%HINT:  Hiflreiche Funktion: imfilter
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    
    edgesXyz = zeros(size(normals));
end

function [edgesGray] = evc_maximum_edge(edgesXyz)
%evc_maximum_edge berechnet die St�rke der Kante pro Pixel als das Maximum
% der Kanstenst�rke aller Achsen pro Pixel.
%
%   EINGABE
%   edgesXyz...         Ein 3-Kanal-Bild mit der St�rke pro Achse, pro
%                       Kante
%
%   AUSGABE
%   edgesGray...        Ein 1-Kanal-Bild mit der St�rke der Kante pro Pixel

	%HINT: 	Hilfreiche Funktionen: max
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    
    edgesGray = zeros(size(edgesXyz,1),size(edgesXyz,2));
end

function [edgesBlurred] = evc_blur_edges(edgesGray,sigma)
%evc_blur_edges filtert das �bergebene Kantenbild entsprechend einem 16x16
% Gauss-Filter, der das angegebene Sigma verwendet. Dazu wird das Bild mit dem
% entsprechenden 1x16 Gauss-Filter, und dann mit dem entsprechenden 16x1
% Gauss-Filter gefiltert.
%
%   EINGABE
%   edgesGray...        Ein 1-Kanal-Bild mit der St�rke der Kante pro Pixel
%   sigma...            Das Sigma f�r den Gauss-Filter
%
%   AUSGABE
%   edgesBlurred...     Ein 1-Kanal-Bild mit der gefilterten Kante pro
%                       Pixel

	%HINT: 	Hilfreiche Funktionen: fspecial, imfilter
	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    edgesBlurred =  edgesGray;    
end

function [edgeFactor] = evc_strengthen_edges(edgesBlurred,edgeStrength)
%evc_strengthen_edges verst�rkt die Kanten mit dem angegebenen Faktor. Dazu
% wird die St�rke der Kante mit einem Faktor multipliziert. Im
% Anschluss wird sichergestellt, dass keine Werte �ber 1 vorkommen, indem
% alle Werte die �ber 1 w�ren, auf 1 gesetzt werden. Au�erdem wird das
% Ergebnis als 3-Kanal-Bild zur�ckgegeben, in dem in jedem Kanal, der
% gleiche Wert gespeichert ist.
%
%   EINGABE
%   edgesBlurred...     Ein 1-Kanal-Bild mit der St�rke der Kante pro
%                       Pixel.
%   edgeStrength...     Der Faktor, der zum st�rken der Kanten verwendet
%                       wird.
%
%   AUSGABE
%   edgeFactor...       Ein 3-Kanal-Bild mit der St�rke der Kante pro Pixel.

	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    
    edgeFactor = zeros([size(edgesBlurred), 3]);
end

function [result] = evc_blend_edges(color, edgeColor, edgeFactor)
%evc_strengthen_edges interpoliert zwischen dem Farbbild, und der
% Kantenfarbe. Als Interpolations-Parameter soll die Kantenst�rke verwendet
% werden. Wenn diese 1 ist, soll an dieser Position nur die Kantenfarbe
% sichtbar sein. Wenn diese 0 ist, soll an dieser Position nur das Farbbild
% sichtbar sein. Die Werte zwischen 0 und 1 sollen linear interpoliert werden.
%
%   EINGABE
%   color...            Ein 3-Kanal-Farbbild
%   edgeColor...        Ein 3-Kanal-Bild in der Gr��e von color, das nur
%                       die Kantenfarbe enth�lt.
%   edgeFactor...       Der Interpolations-Parameter.
%
%   AUSGABE
%   result...           Das interpolierte Bild.

	%NOTE: 	Die folgende Zeile kann gel�scht werden. Sie
	%		verhindert, dass die Funktion, solange sie nicht implementiert wurde,
	%		abst�rzt.
	%TODO:  Implementiere diese Funktion.
    
    result = color;
end
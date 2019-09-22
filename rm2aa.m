function [ax,angle] = rm2aa(R)
% -------------------------------------------------------------------------
% Rotation-Matrix to Axis-Angle Function
% 
% Usage:
%       [ax,angle] = rm2aa(R)
%
% Input:
%       <R>         (3X3) Rotation Matrix.
%
% outputs:
%       <ax>        (3X1) axis of rotation as unit vector passing throught the origin.
%       <angle>     (1X1) angle of rotation in Radian (for proper rotation only).
% 
% Source:           http://rip94550.wordpress.com/2008/05/20/axis-and-angle-of-rotation/
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, January 2010
% -------------------------------------------------------------------------

% Find the axis (vector passing through origin)
[a,b] = eig(R);     ind = find(imag(diag(b))==0);   ax = a(:,ind(1));

if nargout>1
    % Find the angle (in radian)
    angle = acos((trace(R)-1)./2);
end
return
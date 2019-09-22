function R = aa2rm(ax,angle)
% -------------------------------------------------------------------------
% Rotation-Matrix to Axis-Angle Function
% 
% Usage:
%       R = aa2rm(ax,angle)
%
% Inputs:
%       <ax>        (3X1) axis of rotation as vector passing throught the origin.
%       <angle>     (1X1) angle of rotation in Radian.
% 
% Output:
%       <R>         (3X3) Rotation Matrix.
%
% Source:           http://rip94550.wordpress.com/2008/05/20/axis-and-angle-of-rotation/
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, January 2010
% -------------------------------------------------------------------------

% Find Rotation
ax = unit_vector(ax);
N = [0 ax(3) -ax(2); -ax(3) 0 ax(1); ax(2) -ax(1) 0];   % skew-symmetric matrix
R = eye(3) + sin(angle)*N + (1-cos(angle))*N*N;
return
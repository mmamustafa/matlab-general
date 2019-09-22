function [phi] = reduce_angle_semiCircle(phi)
% -------------------------------------------------------------------------
% Reduce Angle Full Circle Function: To have any given angle between:
% [0:pi] radian.
%
% Usage:
%       [phi] = reduce_angle_fullCircle(phi)
%
% Input:
%       <phi>           (1XM) angles before reduction
%
% Output:
%       <phi>           (1XM) angle after reduction
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, July 2009
% -------------------------------------------------------------------------
phi = reduce_angle_fullCircle(phi);
ind = find(phi<0);
phi(ind) = phi(ind) + pi;
return
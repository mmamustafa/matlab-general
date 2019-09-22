function [phi] = reduce_angle_fullCircle(phi)
% -------------------------------------------------------------------------
% Reduce Angle Full Circle Function: To have any given angle between:
% [-pi:pi] radian.
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
phi = rem(phi,2.0*pi);
ind = abs(phi)>pi;
phi(ind) = rem(phi(ind),2.0*pi) - sign(phi(ind))*2.0*pi;
return
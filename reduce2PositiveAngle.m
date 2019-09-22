function [phi] = reduce2PositiveAngle(phi)
% -------------------------------------------------------------------------
% Reduce Angle Full Circle Function: To have any given angle between:
% 0 < phi <= 2pi
%
% Usage:
%       [phi] = reduce2PositiveAngle(phi)
%
% Input:
%       <phi>           (1XM) angles before reduction
%
% Output:
%       <phi>           (1XM) angle after reduction
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, February 2013
% -------------------------------------------------------------------------
phi = rem(phi,2.0*pi);      % -pi <= phi <= pi
ind = find(phi<=0);
phi(ind) = phi(ind) + 2*pi;
return
% Use <distance_point_point> instead
% ###########################################
% calcDist
% -----------------------------------------------------------------------
%   calcDist(dx,dy) Computes the distance between 2 points
%   given their differences (dx,dy).
%   Example: to find the distance between (2,3) and (-1,4)
%       dx = 2-(-1) = 3
%       dy = 3-4 = -1
%       calcDist(dx,dy) = 3.1623
%
%   dx and dy can be vectors!
% -----------------------------------------------------------------------
function dist = calcDist(dx,dy)
dist = sqrt(dx.^2+dy.^2);
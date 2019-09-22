function [out] = isPointInPolygon(point,polygon)
% -------------------------------------------------------------------------
% Test if a given point is inside a polygon. This function uses ray casting
% method in 2D only.
%
% Usage:
%       [out] = isPointInPolygon(point,polygon)
%
% Inputs:
%       <point>     (2XN)   points
%
%       <polygon>   (1XM)   cellarrays, where each cell corresponds to a polygon
%
% Output:
%       <out>       (NXM)   2D binary Array, where 1==in, 0==out
%                           rows = points
%                           columns = polygons
%
% Implementation:   Mohamed Mustafa
%                   University of Manchester, September 2013
% -------------------------------------------------------------------------

% Default values
if nargin<2
    error('Bad Parameters!');
end

N = size(point,2);      % number of points
M = size(polygon,2);    % number of polygons

% Create rays from points (all rays have the same direction.
ray = [point; ones(1,N); zeros(1,N)];

out = zeros(N,M);   % pre-allocate memory for speed
for i=1:M
    % create lineSegments from polygon(i)
    t1 = polygon{i}(:,1:end-1);
    t2 = polygon{i}(:,2:end);
    targets = [t1;t2-t1];
    
    % find the number of intersection with
    [~,~,~,NumIntersections] = rayCast(ray, targets, 'lineSegments');
    out(:,i) = mod(NumIntersections,2)';
end
return
function [dist,proj] = distance_point_plane(point,plane)
% -------------------------------------------------------------------------
% Distance between point and plane in 3D space only.
% 
% Usage:
%       [dist,proj] = distance_point_plane(point,plane)
%
% Inputs:
%       <point>     (3XM) points in 3D
%       <plane>     (6XM) planes in point-normal format.
%
% Output:
%       <dist>      (1XM) SIGNED distance
%       <proj>      (3XM) projection of each point on the plane
% 
% Source:           http://mathworld.wolfram.com/Point-PlaneDistance.html
%                   http://local.wasp.uwa.edu.au/~pbourke/geometry/pointline/
%                   http://www.9math.com/book/projection-point-plane
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, January 2010
% -------------------------------------------------------------------------
if nargin<2
    error('Bad Parameters!');
end
if size(point,2)~=size(plane,2)
    error('point & plane should have same number of columns!');
end
if size(point,1)~=3
    error('All parameters should be in 3D space!');
end

p1 = point;     p0 = plane(1:3,:);      n = plane(4:6,:);
dist = dot(p1-p0,unit_vector(n));     % this is the SIGNED distance

if nargout>1
    t = dot(n,p0-p1)./dot(n,n);
    proj = p1 + n.*repmat(t,3,1);
end
return
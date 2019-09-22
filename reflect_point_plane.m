function point2 = reflect_point_plane(point,plane)
% -------------------------------------------------------------------------
% Reflection of point about plane in 3D space.
% 
% Usage:
%       point2 = reflect_point_plane(point,plane)
%
% Inputs:
%       <point>     (3XM) points in 3D
%       <plane>     (6XM) planes in point-normal format.
%
% Output:
%       <point2>    (3XM) reflected points in 3D
% 
% Source:           http://mathworld.wolfram.com/Reflection.html
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

p1 = point;     n = plane(4:6,:);
D = distance_point_plane(point,plane);
point2 = p1 - 2*repmat(D,3,1).*unit_vector(n);
return
function line = intersection_plane_plane(P1,P2)
% -------------------------------------------------------------------------
% Intersection between 2 sets of plane in 3D space.
%
% Usage:
%       line = intersection_plane_plane(P1,P2)
%
% Inputs:
%       <P1>        (6XM) First set of planes in point-normal format
%       <P2>        (6XM) Second set of planes in point-normal format
%
% Outputs:
%       <line>      (4XM) lines of intersection in the following format:   r1 + t*v1
% 
% Source:       http://mathworld.wolfram.com/Plane-PlaneIntersection.html
%               http://mathworld.wolfram.com/HessianNormalForm.html
%
% Implementation:   Mohamed Mustafa
%                   University of Manchester, April 2013
% -------------------------------------------------------------------------

if nargin<2
    error('Bad Parameters!');
end
if size(P1,1)~=size(P2,1) || size(P1,2)~=size(P2,2)
    error('Size of P1 & P2 should be the same!');
end

NP = size(P1,2);    % number of planes

% Extract normal vectors and put them as unit vectors
n1 = unit_vector(P1(4:6,:));         n2 = unit_vector(P2(4:6,:));

% Direction vector of the intersection line
v = cross(n1,n2);
% Expection for similar planes (or planes that are parallel)
ind = find(sum(v.^2)<1e-3);     % index of direction vectors with magnitude less than small number
if ~isempty(ind)
    rot = eul2dcm(deg2rad(10*rand(1,3)));   % Random rotation matrix
    t1 = rot*n1(:,ind);
    v(:,ind) = cross(n1(:,ind),t1);
end


% To Compute the point on the intersection line
% find shortest distance (and projection) to the origin of each plane as 
% given in the source.
[p1,~] = distance_point_plane(zeros(3,NP),P1);
[p2,~] = distance_point_plane(zeros(3,NP),P2);
p = [];
for i=1:length(p1)
    t1 = [n1(:,i),n2(:,i)]'\-[p1(i);p2(i)];
    p = [p t1];
end

line = [p;v];
return




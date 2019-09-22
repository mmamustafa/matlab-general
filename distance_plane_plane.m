function dist = distance_plane_plane(p1,p2)
% -------------------------------------------------------------------------
% Distance between two sets of planes in the sense of how close the two
% planes are in normal/point(of shortest distance to origin) format.
%
% Inputs:
%       <p1>        (6XM) first set of planes in normal/point(with shortest
%                         distance to origin)
%       <p2>        (6XM) Second set of planes in normal/point(with shortest
%                         distance to origin)
%
% Outputs:
%       <dist>      (1XM) distance metric between the two planes in parameter space
%
% Implementation:   Mohamed Mustafa
%                   University of Manchester, May 2013
% -------------------------------------------------------------------------
if nargin<2
    error('Bad Parameters!');
end
if size(p1,1)~=size(p2,1) || size(p1,2)~=size(p2,2)
    error('p1 & p2 should have the same size! (6XM Matrix).');
end
if size(p1,1)<6
    error('p1 & p2 should have size of 6XM !');
end

% Change the point of each plane to the closeset to the origin
np = size(p1,2);    % number of planes
[~,p1(1:3,:)] = distance_point_plane(zeros(3,np),p1);
[~,p2(1:3,:)] = distance_point_plane(zeros(3,np),p2);

% Unit vector all direction vectors
p1(4:6,:) = unit_vector(p1(4:6,:));
p2(4:6,:) = unit_vector(p2(4:6,:));

% use cross-product on directions, and find the absolute value of the
% result to get the first part.
part1 = sum(cross(p1(4:6,:),p2(4:6,:)).^2);

% use the distance (point-point) on points to get the second part
part2 = distance_point_point(p1(1:3,:),p2(1:3,:));

% return the distnace by adding <part1> and <part2>
dist = part1 + part2;
return
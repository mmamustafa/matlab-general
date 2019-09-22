function dist = distance_plane_plane2(p1,p2)
% -------------------------------------------------------------------------
% Distance between two sets of planes in the sense of how close the two
% planes are in Hessian Normal Form.
%
% Inputs:
%       <p1>        (4XM) first set of planes in Hessian Normal Form
%       <p2>        (4XM) Second set of planes in Hessian Normal Form
%
% Outputs:
%       <dist>      (1XM) distance metric between the two planes in parameter space
%
% Implementation:   Mohamed Mustafa
%                   University of Manchester, November 2015
% -------------------------------------------------------------------------
if nargin<2
    error('Bad Parameters!');
end
if size(p1,1)~=size(p2,1) || size(p1,2)~=size(p2,2)
    error('p1 & p2 should have the same size! (4XM Matrix).');
end
if size(p1,1)<4
    error('p1 & p2 should have size of 4XM !');
end

n1 = p1(1:3,:);     d1 = p1(4,:);
n2 = p2(1:3,:);     d2 = p2(4,:);

dist1 = abs(d1-d2);                     % difference between distances to origin
dist2 = distance_point_point(n1,n2);    % difference between normals

dist = dist1 + dist2;                   % final distance
return
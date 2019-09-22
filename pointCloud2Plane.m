function plane = pointCloud2Plane(points,tol)
% -------------------------------------------------------------------------
% This function extracts the best plane that fits <points> using least
% square and PCA.
% 
% Usage:
%       plane = pointCloud2Plane(points,tol)
%
% Inputs:
%       <points>    (3XM) points in 3D
%
%       <tol>       tolerance for accepting collinearity.
%                   max distance to the line to accept.
%
% Output:
%       <plane>     (6XM) planes in point-normal format.
% 
% Implementation:   Mohamed Mustafa
%                   University of Manchester, April 2013
% -------------------------------------------------------------------------

% Default values
if nargin<2
    tol = 1e-3;
end

if size(points,1)<3
    error('<points> should be 3D!')
end

P = mean(points,2);       % point on the plane

% Use singular value decomposition
[~,s,v] = svd(cov(points'));

% get the first vector on the plane from <v> and <s>
if s(1,1)>tol
    v1 = v(:,1);
else
    % This is the case of all <points> are actually one point within <tol>
    % ball. 
    v1 = rand(3,1);
end

% get the second vector on the plane from <v> and <s>
if s(2,2)>tol
    v2 = v(:,2);
else
    % This is the case of all <points> are collinear within <tol> distance.
    v2 = rand(3,1);
end

% The normal vector to the plane is computed using <v1> and <v2>
N = cross(v1,v2);
plane = [P;N];
return
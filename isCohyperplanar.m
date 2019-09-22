function y = isCohyperplanar(X,threshold)
% check whether the points in X are co-hyperplanar.
% Works in ND.
%
% Inputs:
%   <X>             (DXN)   Points in DD
%   <threshold>     (1X1)   largest distance to hyperplane.

if nargin<2
    threshold = 1e-4;   % 0.1 mm
end

% (1) Check the number of points
[D,N] = size(X);    % dimesnion, number of point
if N<=D
    disp('Number of points is less than or equal to Dimension! They form a hyperplane anyway.')
    y = 1;
    return
end

% (2) Compute the hyperplane using the first three points
hyperplane = estimate_hyperplane(X);

% (3) Find the distance between all point and the plane
dist = abs(distance_point_hyperplane(X,repmat(hyperplane,1,N)));

% (4) Check the distance against the threshold
if any(dist>threshold)
    y = 0;
else
    y = 1;
end
return
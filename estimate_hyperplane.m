function hyperplane = estimate_hyperplane(points)
% -------------------------------------------------------------------------
% This function extracts the best hyperplane that fits <points> using least
% square and PCA.
%
% Usage:
%       hyperplane = estimate_hyperplane(points)
%
% Inputs:
%       <points>    (D X M) points in ND
%
% Output:
%       <plane>     (2D X M) planes in point-normal format.
% 
% Implementation:   Mohamed Mustafa
%                   April 2013, May 2016
% -------------------------------------------------------------------------

% Default values
if nargin<1
    hyperplane = [];
    return
end

[D,M] = size(points);   % dimension, number of points
if M<D
    disp('error: <points> should have at least 3 columns!')
    hyperplane = [];
    return
end

P = mean(points,2);       % point on the plane

% Use singular value decomposition
[~,~,v] = svd(cov(points'));

% The normal vector to the plane corresponds to least singular value
N = v(:,D);
hyperplane = [P;N];
return
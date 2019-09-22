function [L] = estimate_line(X)
% -------------------------------------------------------------------------
% Estimate line parameters from point cloud using least square and
% Principal component analysis (PCA).
% Works with 2D & 3D data.
%
% Usage:
%       [L] = estimate_line(X)
%
% Input:
%       <X>         (2XM) or (3XM) points
%
% Output:
%       <L>         (4X1) or (6X1) Best fit line with the following format:
%                                  r0 + t*v0
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, October 2009
% -------------------------------------------------------------------------

if nargin<1
    error('Bad Parameters!');
end
if size(X,2)<2
    error('Infinite number of lines go thru one point! Two or more points are required!');
end

% Position vector is the mean of the data
r0 = mean(X,2);

% Direction vector is found by looking at the data covariance matrix, 
% then, find eigenvector that corresponds to the largest eigenvalue.
% Direction vector is normalized.
% More details are at Principal Componenet Analysis topic
[~,~,v] = svd(cov(X')); % <s> sre the singular values in order, <v> corresponding eigenvectors
v0 = v(:,1);

% Final Line
L = [r0;v0];
return


% >>>> Old implementation using eigenvectors
% Cov_X = cov(X');
% [V,D] = eig(Cov_X);
% [value,ind] = max(diag(D)); % largest eigenvalue
% v0 = V(:,ind);              % corresponding eigenvector

function y = isColinear(X,threshold)
% check if the points in X are colinear or not.
% Works in 2D or 3D 
%
% Inputs:
%   <X>             (2XN) or (3XN)  Points
%   <threshold>     (1X1)           smallest distance to plane formed by any three
%   points

if nargin<2
    threshold = 1e-4;   % 0.1 mm
end

% (1) Check the number of points
NP = size(X,2);
if NP<3
    disp('Number of points is less than 3! They form a line anyway.')
    y = 1;
    return
end

% (2) Compute the line using the first two points
L = estimate_line(X(:,1:2));

% (3) Find the distance between all point and the plane
dist = distance_point_line(X,repmat(L,1,NP));

% (4) Check the distance against the threshold
if any(dist>threshold)
    y = 0;
else
    y = 1;
end


% 
% % (1) Find the mean of X
% mean_X = mean(X,2);
% 
% % (2) Subtract the mean from the original points
% X = X-repmat(mean_X,1,size(X,2));
% 
% % (3) get the singular values
% [~,S,~] = svd(X*X');
% S
% cond(X*X')
% % (4) check the last singlar value against threshold
% if S(end)<threshold
%     y = 1;
% else
%     y = 0;
% end
return
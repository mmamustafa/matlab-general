function y = isCoplanar(X,threshold)
% check if the points in X are coplanar or not.
% Works in 3D only
%
% Inputs:
%   <X>             (3XN)   Points in 3D
%   <threshold>     (1X1)   smallest distance to plane formed by any three
%   points

if nargin<2
    threshold = 1e-4;   % 0.1 mm
end

% (1) Check the number of points
NP = size(X,2);
if NP<4
    disp('Number of points is less than 4! They form a plane anyway.')
    y = 1;
    return
end

% (2) Compute the plane using the first three points
plane = [X(:,1);cross(X(:,2)-X(:,1),X(:,3)-X(:,1))];

% (3) Find the distance between all point and the plane
dist = distance_point_plane(X,repmat(plane,1,NP));

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
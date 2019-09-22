function X = sortPoints2D_CCW(X)
% -------------------------------------------------------------------------
% Sort 2D points CCW
%
% Inputs:
%       <X>         (2XM) 2D Points
%
% Outputs:
%       <X>         (2XM) 2D Points (after sorting)
%
% Implementation:   Mohamed Mustafa
%                   UoM, August 2015
% -------------------------------------------------------------------------

NP = size(X,2);             % number of points
C = mean(X,2);              % centroid
D = X-repmat(C,1,NP);       % remove the centroid
th = atan2(D(2,:),D(1,:));  % get the angle of each point
[~,i] = sort(th);           % ascenting sort for angles
X = X(:,i);
return
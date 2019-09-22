function [R,T] = getRigidTransformation(xA,xB)
% Find Rotation and Translation that results in 3D rigid transformation
% from xA to xB. (no scaling)
%
% xB = getTransformPoints(xA,Rt,Tt)
%
% Inputs:
% 	<Xm>        (3XM) Model points
%   <Xd>        (3XN) Data points, where M<=N
% 
% Outputs:
%   <R>         (2X2) or (3X3)  Rotation matrix
%   <T>         (2X1) or (3X1)  Translation vector
%
% http://graphics.stanford.edu/~smr/ICP/comparison/eggert_comparison_mva97.pdf

% calculate rotation
mA = mean(xA,2);
mB = mean(xB,2);
np = size(xA,2);
xA_m = xA - repmat(mA,1,np);	xB_m = xB - repmat(mB,1,np);
C = xA_m*xB_m';     % covariance
[u,~,v] = svd(C);
if size(xA,1)==2
    R = v*[1 0;0 det(v*u')]*u';
    %R = u*diag([1 det(u*v')])*v';      % this one does not work!!
elseif size(xA,1)==3
    R = v*[1 0 0;0 1 0;0 0 det(v*u')]*u';
    %R = u*diag([1 1 det(u*v')])*v';
else
    error('Point dimension should be 2 or 3.')
end
% calculate translation
T = mB - R*mA;
return
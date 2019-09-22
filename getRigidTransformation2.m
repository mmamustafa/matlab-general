function [R,T] = getRigidTransformation2(xA,xB)
% Find Rotation and Translation that results in 3D rigid transformation
% from xA to xB, (no scaling), where xA and xB are either 2D lines or
% planes.
%
% This website recommends to use LM-optimization to find R and T, however,
% here we have something that is a bit simpler with estimation decoupled
% between R and T.
%
% >>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<
% >>>>>> DOES NOT WORK IN 3D <<<<<<<<
% >>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<
%
% Planes and lines are defined in Hessian Normal From.
%
% xB = getTransformLines(xA,Rt,Tt)          2D
% xB = getTransformPlanes(xA,Rt,Tt)         3D
%
% Inputs:
% 	<Xm>        (3XM) Model lines
%               (4XM) Model planes
%   <Xd>        (3XM) Data lines
%               (4XM) Data planes
% 
% Outputs:
%   <R>         (2X2) or (3X3)  Rotation matrix
%   <T>         (2X1) or (3X1)  Translation vector

[D,M] = size(xA);       % D = dimension+1,  M = number of elements
D = D-1;                % Dimension: 2, 3

if D==2
    nA = xA(1:2,:);     dA = xA(3,:);
    nB = xB(1:2,:);     dB = xB(3,:);
elseif D==3
    nA = xA(1:3,:);     dA = xA(4,:);
    nB = xB(1:3,:);     dB = xB(4,:);
else
    error('Dimensions allowed: 2D or 3D!')
end

% Since all vectors are about the origin, no need to remove the centroid.
[u,~,v] = svd(nA*nB');
if D==2
    R = v*[1 0;0 det(v*u')]*u';
else
    R = v*[1 0 0;0 1 0;0 0 det(v*u')]*u';
end
T = nA'\(dB-dA)';
return
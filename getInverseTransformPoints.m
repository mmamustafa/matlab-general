function P = getInverseTransformPoints(P,R,T)
% -------------------------------------------------------------------------
% getInverseTransformPoints function.
%
% Usage:
%       P = getInverseTransformPoints(P,R,T)
%
% Inputs:
%       <P>         (2XM) or (3XM) points before transformation
%       <R>         (2X2) or (3X3) Rotation Matrix
%       <T>         (2X1) or (3X1) Translation Vector
%
% Outputs:
%       <P>         (2XM) or (3XM) points after transformation
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, May 2010
% -------------------------------------------------------------------------

M = size(P,2);      % number of points
D = size(P,1);      % dimension

% Inputs validation
if size(R,1)~=D || size(T,1)~=D || size(T,1)~=size(R,1)
    error('Dimensions of P, R and T do not match!')
end

P = R'*(P - repmat(T,1,M));
return
% -------------------------------------------------------------------------
function angle = get_angle_vectors(X1,X2)
% -------------------------------------------------------------------------
% Find angle (in radian) between two vectors (or two sets of vectors).
% Vectors are normalized and dot-product is employed to find the angle.
% Angle range is [0:pi].
% This function works for N-D vectors
%
% Usage:
%       angle = get_angle_vectors(X1,X2)
%
% Inputs:
%       <X1>    (2XN) or (N-DXN) First set of vectors
%       <X2>    (2XN) or (N-DXN) second set of vectors
%
% Outputs:
%       <angle> (1XN) angle between vectors
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, December 2009
% -------------------------------------------------------------------------
if nargin<2
    error('Bad Parameters!');
end
X1 = unit_vector(X1);       X2 = unit_vector(X2);
angle = real(acos(dot(X1,X2)));
return
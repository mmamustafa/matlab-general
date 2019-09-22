function V3 = projection(V1,V2)
% -------------------------------------------------------------------------
% Projection of vector V1 on V2, where all vectors have the origin (0) as
% the starting point.
% 
% Usage:
%       V3 = projection(V1,V2)
%
% Inputs:
%       <V1>        (DXM) vector where D is dimension, M is number of vectors
%       <V2>        (DXM) vector where D is dimension, M is number of vectors
%
% Outputs:
%       <V3>        (DXM) vector where D is dimension, M is number of vectors
%
% Implementation:   Mohamed Mustafa
%                   University of Manchester, February 2014
% -------------------------------------------------------------------------
if nargin<2
    error('Bad Parameters!');
end
if size(V1,2)~=size(V2,2)
    error('V1 & V2 should have same number of columns!');
end
if size(V1,1)~=size(V2,1)
    error('V1 & V2 should have same number of rows!');
end

D = size(V1,1);     % dimension

% Change V2 to unit vector
V2 = unit_vector(V2);

% dot product of <V1> and <V2>
t1 = dot(V1,V2);    % scalars

% multiply the scalars by the unit vector of <V2>
V3 = repmat(t1,D,1).*V2;
return
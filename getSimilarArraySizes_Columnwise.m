function [X1,Y1] = getSimilarArraySizes_Columnwise(X,Y)
% This function returns two array with similar "column-size" to be used in
% functions such as: distance_point_point, distance_point_line, etc...
% 
% Each pair (X(:,i), Y(:,j)) is unique for all possible values of i and j.
%
% X1 = [x1 x2 ... xm | x1 x2 ... xm | ... | x1 x2 ... xm],
% Y1 = [y1 y1 ... y1 | y2 y2 ... y2 | ... | yn yn ... yn]
% where x1, y1 are columns of X and Y, respectively.
%
% Inputs:
%   <X>     (A , M)
%   <Y>     (B , N)
%
% Outputs:
%   <X1>    (A , M*N)
%   <Y1>    (B , M*N)
%
% Mohamed Mustafa, August 2015

[~,M] = size(X);    [B,N] = size(Y);
X1 = repmat(X,1,N);
Y1 = reshape(repmat(Y',1,M)',B,[]);
return
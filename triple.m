function out = triple(X1,X2,X3)
% -------------------------------------------------------------------------
% Vector TRIPLE product.
%   http://en.wikipedia.org/wiki/Triple_product
% -------------------------------------------------------------------------
out = dot(cross(X1,X2),X3);
return
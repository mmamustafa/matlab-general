% calcRecip
% -----------------------------------------------------------------------
%   calcRecip(x1,y1,x2,y2) Computes the reciprocal of to
%   a line and passing thru the first point
% -----------------------------------------------------------------------

function [m b] = calcRecip(x1,y1,x2,y2)

if(y1==y2)
    m = [];
    b = [];
else
    m = -(x1 - x2)/(y1 - y2);
    b = y1 - m*x1;
end
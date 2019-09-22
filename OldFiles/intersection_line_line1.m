% intersection_line_line
% -----------------------------------------------------------------------
%   intersection_line_line1(m1,b1,m2,b2) find the intersection Point of two Lines
% -----------------------------------------------------------------------
% OLD VERSION.... New version is at "intersection_line_line" file with use
% of position and direction vectors
function [x y] = intersection_line_line1(m1,b1,m2,b2)

if(m1==m2)
    % no intersection point
    x = [];
    y = [];
else
    % point of intersection
    x = (b2 - b1)/(m1 - m2);
    y = m1*x + b1;
end


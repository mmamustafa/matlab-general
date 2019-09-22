% CPB2C
% -----------------------------------------------------------------------
%   CPB2C(x1,y1,r1,x2,y2,r2) find Center Point Between 2 Circles.
%   If the circles intersect at one or two point,
%   the function will return null.
% -----------------------------------------------------------------------
function [x,y] = CPB2C(x1,y1,r_1,x2,y2,r2)

dx = x2 - x1;
dy = y2 - y1;
dist = sqrt(dx^2+dy^2)
theta = calcAngle(dx,dy);

if(dist<=(r_1+r2))
    % no center point because the circles are touching each other
    x = [];
    y = [];
else
    dist = (dist-r_1-r2)/2;
    x = x1 + (r_1+dist)*cos(theta);
    y = y1 + (r_1+dist)*sin(theta);
end
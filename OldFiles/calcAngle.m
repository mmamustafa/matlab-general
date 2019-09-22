% Use <atan> instead...
% #########################
% calcAngle
% -----------------------------------------------------------------------
%   calcAngle(dx,dy) Computes the angle (in radian)
%   between +ve x-axis and line formed by 2 points given
%   their differences (dx,dy).
%   Example: to find the distance between (2,3) and (-1,4)
%       dx = 2-(-1) = 3
%       dy = 3-4 = -1
%       calcAngle(dx,dy) = -0.3218
% -----------------------------------------------------------------------
function phi = calcAngle(dx,dy)
if(dx==0)
    phi = sign(dy)*pi/2;
else
    phi = atan(dy/dx);
end

if(dx<0)
    phi = phi+pi;
end
phi = angleMod(phi);
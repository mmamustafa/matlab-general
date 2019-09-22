function [pts] = circle(x0,y0,r,c_p)
% -------------------------------------------------------------------------
% Circle Function is to return points that constitute circle and graph the
% result in 2D.
%
% Usage:
%       [pts] = circle(x0,y0,r,c_p)
%
% Inputs:
%       <x0>            (1XM) x-centers
%       <y0>            (1XM) y-centers
%       <r>             (1XM) radii
%       <c_p>           (1X1) color/points, e.g.: 'b.' == blue with dots,
%                                                 'r*' == red with stars
%
% Output:
%       <pts>           (2XM) points of the circle
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, March 2009
% -------------------------------------------------------------------------
if nargin<4
    c_p = 'b.';
end
if(length(x0)~=0)
    nop = 200;  % later, make this variable depnding on radius
    t0 = 2*pi/nop;
    x = [];
    y = [];
    r = abs(r);
    for i=1:nop
        x = [x, x0+r*cos(t0*(i))];
        y = [y, y0+r*sin(t0*(i))];
    end
end
if nargout>0
    pts = [x;y];
else
    plot(x,y,c_p);
end
return
function line_gf = line2D_pd2gf(line_pd)
% Line in 2D function:
% Position/Direction --> General Form
% 
% Inputs:
%       <line_pd>   (4XM) Position direction format (r0 + t*v0)
%
% Output:
%       <line_gf>   (3XM) Line parameters in General Form (A,B,C)

x1 = line_pd(1,:);                  y1 = line_pd(2,:);
x2 = line_pd(3,:)+line_pd(1,:);     y2 = line_pd(4,:)+line_pd(2,:);
dx = x2-x1;                         dy = y2-y1;

A = dy;         B = -dx;            C = dx.*y1-dy.*x1;
line_gf = [A;B;C];
return
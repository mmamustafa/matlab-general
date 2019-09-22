function line_gf = line2D_tp2gf(point1,point2)
% Line in 2D function:
% Two Points --> General Form
% 
% Inputs:
%       <point1>    (2XM) points in 2D
%       <point2>    (2XM) points in 2D
%
% Output:
%       <line>      (3XM) Line parameters in General Form (A,B,C)

x1 = point1(1,:);       y1 = point1(2,:);
x2 = point2(1,:);       y2 = point2(2,:);
dx = x2-x1;             dy = y2-y1;

A = dy;         B = -dx;            C = dx.*y1-dy.*x1;
line_gf = [A;B;C];
return
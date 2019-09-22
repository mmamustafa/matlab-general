function [p1,p2,t1,t2] = intersection_circle_line(C,L)
% -------------------------------------------------------------------------
% Intersection of circle with line.
% If there is no intersection, output is NaN.
%
% Usage:
%       [p1,p2] = intersection_circle_line(C,L)
%
% Inputs:
%       <C>         (3XM) circles in the following format:  (x - x_c)^2 + (y - y_c)^2 = r^2
%       <L>         (4XM) lines the following format:       x = p_x + v_x*t
%                                                           y = p_y + v_y*t
%
% Outputs:
%       <p1>        (2XM) points of intersection
%       <p2>        (2XM) points of intersection
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, May 2010
% -------------------------------------------------------------------------

% from <C>
x_c = C(1,:);       y_c = C(2,:);       r_c = C(3,:);
% from <line>
p_x = L(1,:);       p_y = L(2,:);       v_x = L(3,:);       v_y = L(4,:);

a = v_x.^2 + v_y.^2;
b = 2*(v_x.*(p_x - x_c) + v_y.*(p_y - y_c));
c = (p_x - x_c).^2 + (p_y - y_c).^2 - r_c.^2;

t1 = (-b+sqrt(b.^2-4*a.*c))./(2*a);
t2 = (-b-sqrt(b.^2-4*a.*c))./(2*a);

x1 = p_x + v_x.*t1;         y1 = p_y + v_y.*t1;
ind = union(find(imag(x1)),find(imag(y1)));
x1(ind) = nan;              y1(ind) = nan;
p1 = [x1;y1];

x2 = p_x + v_x.*t2;         y2 = p_y + v_y.*t2;
ind = union(find(imag(x2)),find(imag(y2)));
x2(ind) = nan;              y2(ind) = nan;
p2 = [x2;y2];
return


function [point,info] = intersection_line_line(L1,L2)
% -------------------------------------------------------------------------
% Intersection between 2 sets of lines in 2D/3D spaces.
%
% Usage:
%       [point,info] = intersection_line_line(L1,L2)
%
% Inputs:
%       <L1>        (4XM) or (6XM) First set of lines with the following format:   r1 + t*v1
%       <L2>        (4XM) or (6XM) Second set of lines with the following format:  r2 + t*v2
%
% Outputs:
%       <point>     (3XM) points of intersection
%       <info>      (1XM) -->   0:  Lines are skewed or intersect
%                               1:  Lines are parallel or on each other
% 
% Source:
%                   http://mathworld.wolfram.com/Line-LineIntersection.html
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, October 2009
% -------------------------------------------------------------------------

if nargin<2
    error('Bad Parameters!');
end
if size(L1,1)~=size(L2,1) || size(L1,2)~=size(L2,2)
    error('Size of L1 & L2 should be the same!');
end
if size(L1,1)==4
    % Make 2D problem 3D problem to ease the calculations later.
    % All results will be in 3D.
    z = zeros(1,size(L1,2));
    L1 = [L1(1:2,:); z; L1(3:4,:); z];
    L2 = [L2(1:2,:); z; L2(3:4,:); z];
end
[dist,t1,t2,info] = distance_line_line(L1,L2);   % use distance between 2 lines function
point = L1(1:3,:) + L1(4:6,:).*repmat(t1,3,1);

% if the lines are parallel (or on each other) --> info == 1, and "point"
% value is in the direction of both lines.
ind = find(info==1);
point(:,ind) = L1(4:6,ind);
return
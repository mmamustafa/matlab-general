function arc(C,P1,P2)
% -------------------------------------------------------------------------
% Plot arc from <P1> to <P2> counterclock-wise with center at <C>.
% 
% Usage:
%       arc(C,P1,P2);
%
% Input:
%       <C>         (2XM) Center of the arcs
%       <P1>        (2XM) First set of points in 2D
%       <P2>        (2XM) Second set of points in 2D
%
% 
% Implementation:   Mohamed Mustafa
%                   University of Manchester, September 2012
% -------------------------------------------------------------------------
if nargin<3
	error('Bad Parameters!');
end
if size(P1,2)~=size(P2,2) || size(C,2)~=size(P2,2)
    error('P1 & P2 should have same number of columns!');
end
R = distance_point_point(C,P1);
if any(~isEqual(R,distance_point_point(C,P2)))
    error('<P1> and <P2> do not have the same distance to <C>!');
end

v1 = P1-C;
v2 = P2-C;
v3 = [0 -1;1 0]*v1; % (as you suggested)
na = size(C,2);
for i=1:na
    a = linspace(0,mod(atan2(det([v1(:,i),v2(:,i)]),dot(v1(:,i),v2(:,i))),2*pi));
    % Note the absence of the 'abs' function in 'atan2'
    v = v1(:,i)*cos(a)+v3(:,i)*sin(a);
    plot(v(1,:)+C(1,i),v(2,:)+C(2,i),'b')
    if i==1
        hold on;
    end
end
axis equal
hold off;
return
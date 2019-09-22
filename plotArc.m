function plotArc(AR,col)
% Plot arc from <P1> to <P2> counterclock-wise with center at <C>.
%
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>> ONLY WORKS FOR 2D in the mean time >>>>>>>>>>>
% >>>>> Check the source below for higher dimensions >>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% Input:
%   <AR>        (6,N)	Array of dimension <2> and has <N> arcs in the 
%                       following format: [C;A1;A2], where:
%                       point 1 <P1> to point 2 <P2> counterclock-wise with center at <C>.
% 
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

if nargin<2
    col = 'b';
end

% Extract elements
C = AR(1:2,:);
P1 = AR(3:4,:);
P2 = AR(5:6,:);

R = distance_point_point(C,P1);     % this cannot be zero
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
    plot(v(1,:)+C(1,i),v(2,:)+C(2,i),col)
    if i==1
        hold on;
    end
end
%axis equal
hold off;
return
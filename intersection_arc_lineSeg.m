function [Pa,Pb] = intersection_arc_lineSeg(AR,LS)
% This function returns the intersection point/s between arc <AR> and line
% segment <LS>.
%
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>> ONLY WORKS FOR 2D in the mean time >>>>>>>>>>>
% >>>>> Check the source below for higher dimensions >>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% Inputs:
%   <AR>        (6,N)	Array of dimension <2> and has <N> arcs in the 
%                       following format: [C;A1;A2], where:
%                       point 1 <A1> to point 2 <A2> counterclock-wise with center at <C>.
% 
%   <LS>        (4,N)   Array of dimension <2> and has <N> Line Segments in
%                       the following format: P1 + t*D1
%                       P1 is the starting point and D1 is the ending point.
%                       0 <= t <= 1
%
% Outputs:
%   <Pa>        (2,N)   Array of dimension <2> the first point of
%                       intersection
%                       (if any is found, otherwise, NaN is presented)
%
%   <Pb>        (2,N)   Array of dimension <2> the first point of
%                       intersection
%                       (if any is found, otherwise, NaN is presented)
%
% Source:           My own implementation!
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

% (1) Convert Arc to parametric form: C + R*[cos(theta);sin(theta)]
%     where:
%               theta = alpha + beta*t2
%               0 <= t2 <= 1
%               0 <= alpha <  2pi
%               0 <  beta  <  2pi
%           alpha <= theta <= alpha+2pi

AR = arc2D_cpp2pf(AR);

% (2) Extract elements
C = AR(1:2,:);          % centers of arcs
R = AR(3,:);            % radii of arcs
alpha = AR(4,:);        % starting angles
beta = AR(5,:);         % changing angles
P1 = LS(1:2,:);         % Positions of Line Segments
D1 = LS(3:4,:);         % Directions of Line Segments

% (3) Find possible values for <t1> and <t2>
k = P1(1,:) - C(1,:);       l = D1(1,:);
m = P1(2,:) - C(2,:);       n = D1(2,:);

a = (l.^2 + n.^2);      % This cannot be zero, otherwise the line is not well-defined
b = 2*(k.*l + m.*n);
c = k.^2 + m.^2 - R.^2;

% <t1> for the line segment <LS>
t1_1 = (-b-sqrt(b.^2-4*a.*c))./(2*a);
t1_2 = (-b+sqrt(b.^2-4*a.*c))./(2*a);

% ^^^^^^^^^ ALL GOOD ^^^^^^^^^^^^^^

% <theta>
theta1 = reduce2PositiveAngle(atan2((m + n.*t1_1),(k + l.*t1_1)));
theta2 = reduce2PositiveAngle(atan2((m + n.*t1_2),(k + l.*t1_2)));


% Make sure the following is true:
%           alpha <  theta <= alpha+2pi
% In this case, <t2_1> and <t2_2> should be always +ve.
ind1 = find(theta1<alpha);
theta1(ind1) = theta1(ind1) + 2*pi;
ind2 = find(theta2<alpha);
theta2(ind2) = theta2(ind2) + 2*pi;


% <t2> for the arc <AR>: These values are always +ve, but should be less
% than 1 to be accepted!
t2_1 = (theta1 - alpha)./beta;
t2_2 = (theta2 - alpha)./beta;

% index of <t's> of intersection (Review again later)
ind1 = find((t1_1>=0 & t1_1<=1) & (t2_1>=0 & t2_1<=1) & (imag(t1_1)==0 & imag(t2_1)==0));
ind2 = find((t1_2>=0 & t1_2<=1) & (t2_2>=0 & t2_2<=1) & (imag(t1_2)==0 & imag(t2_2)==0));

% Points of intersection
Pa = NaN(2,length(R));
Pb = Pa;

if size(ind1,2)>0
    Pa(:,ind1) = P1(:,ind1) + D1(:,ind1).*repmat(t1_1(ind1),2,1);
end
if size(ind2,2)>0
    Pb(:,ind2) = P1(:,ind2) + D1(:,ind2).*repmat(t1_2(ind2),2,1);
end

% Sort the points so that <Pa> is always the first point as <t2> increase.
% This is done in case the output of the function is only one argument
% instead of, the result should not be NaN whereas an intersection is found
% and placed at <Pb>!!
% ONLY swith elements in <Pa> and <Pb>.
% >>>> NOTE that t2_1 and t2_2 are no longer consistent with <Pa> and <Pb>!
ind = find((t2_2 - t2_1)<0);
temp = Pa(:,ind);
Pa(:,ind) = Pb(:,ind);
Pb(:,ind) = temp;
return

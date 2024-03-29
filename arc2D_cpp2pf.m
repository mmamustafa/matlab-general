function AR = arc2D_cpp2pf(AR)
% This function converts the arc from (center-2points format) to parametric
% format.
%
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>> ONLY WORKS FOR 2D in the mean time >>>>>>>>>>>
% >>>>> Check the source below for higher dimensions >>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% Input:
%   <AR>        (6,N)	Array of dimension <2> and has <N> arcs in the 
%                       following format: [C;A1;A2], where:
%                       point 1 <A1> to point 2 <A2> counterclock-wise with center at <C>.
% 
% Output:
%   <AR>        (5,N)   Array of dimension <2> and has <N> arcs in the
%                       following format: [C;R;alpha;beta], where:
%                       x = C_x + R*cos(alpha + beta*t)
%                       y = C_y + R*sin(alpha + beta*t)
%                           0 <= t <= 1
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

% (1) Extract elements
C = AR(1:2,:);          % Center of the arcs
A1 = AR(3:4,:);         % Point 1 of the arc
A2 = AR(5:6,:);         % Point 2 of the arc

% (2) Verify inputs
R = distance_point_point(C,A1);     % This cannot be zero
if any(~isEqual(R,distance_point_point(C,A2)))
    error('<A1> and <A2> do not have the same distance to <C>!');
end

% (3) Convert Arc to parametric form: C + R*[cos(theta);sin(theta)]
%     where:
%               theta = alpha + beta*t
%               0 <= t <= 1
%               0 <= alpha <  2pi
%               0 <  beta  <  2pi
%           alpha <= theta <= alpha+2pi

delta1 = A1-C;      alpha = atan2(delta1(2,:),delta1(1,:));
ind = find(alpha<0);
alpha(ind) = alpha(ind) + 2*pi;     % alpha is always +ve
delta2 = A2-C;      beta = atan2(delta2(2,:),delta2(1,:)) - alpha;
ind = find(beta<0);
beta(ind) = beta(ind) + 2*pi;       % To make sure <beta> is always +ve

AR = [C;R;alpha;beta];
return
function P = intersection_ray_lineSeg(R,LS)
% This function returns the intersection point between ray <R> and line
% segment <LS>.
%
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>> ONLY WORKS FOR 2D  >>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>> Check the source below for higher dimensions >>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% 
% Inputs:
%   <R>         (4,N) or (6,N) or (2*D,N)	Array of dimension <D> and has
%                                           <N> Rays in the following
%                                           format: P0 + s*D0
%                                           P0 is the center and D0 is the
%                                           direction. 0 <= s
%   <LS>        (4,N) or (6,N) or (2*D,N)	Array of dimension <D> and has
%                                           <N> Line Segments in the
%                                           following format: P1 + t*D1
%                                           P1 is the starting point and D1
%                                           is the ending point.
%                                           0 <= t <= 1
%
% Outputs:
%   <P>         (2,N) or (3,N) or (D,N)     Array of dimension <D> and has
%                                           <N> points of intersection. If
%                                           no intersection exists --> Inf.
%
% Source:           http://objectmix.com/graphics/132701-ray-line-segment-intersection-2d.html
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

D = size(R,1)/2;        % Dimension
P0 = R(1:D,:);          % Position of Rays
D0 = R(D+1:2*D,:);      % Directions of Rays
P1 = LS(1:D,:);         % Position of Line Segments
D1 = LS(D+1:2*D,:);     % Directions of Line Segments

% Check whether the rays and line segments are parallel using dot-product
temp = dot(perp(D1),D0);
% find the values of <s> & <t> that satisfy both the ray and the line segment
s = dot(perp(D1),P1-P0)./temp;
t = dot(perp(D0),P1-P0)./temp;

P = P0 + repmat(s,D,1).*D0;
P(:,find(s<0 | t<0 | t>1)) = Inf;    % Points outside the limits
return
% =========================================================================
function Vp = perp(V)
% This function returns the perpendicular vector <Vp> to the vector <V>
% >>>>> ONLY IN 2D >>>>>>>
Vp = [V(2,:);-V(1,:)];
return
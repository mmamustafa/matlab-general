function L = points2lines(P)
% This function takes 2 points and returns the line that connects them in
% position/direction format. <D> is the dimension.
%
% For Line Segments between the two points: 0 <= t <= 1
%
% Inputs:
%   <P>         (4,N) or (6,N) or (2*D,N)	Array of dimension <D> and has
%                                           <N> pairs of points
%
% Outputs:
%   <L>         (4,N) or (6,N) or (2*D,N)   Array of dimension <D> and has
%                                           <N> lines in position/direction
%                                           Format (P0 + t*D0)
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

D = size(P,1)/2;    % Dimension
L = [P(1:D,:);(P(D+1:D*2,:)-P(1:D,:))];
return
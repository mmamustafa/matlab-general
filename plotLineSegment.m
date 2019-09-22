function plotLineSegment(LS,col,wid)
% Plot Line Segments.
%
% Works in 2D and 3D
%
% Input:
%   <LS>        (4,N) or (6,N)   Array of dimension <2> or <3> and has <N> Line Segments in
%                       the following format: P1 + t*D1
%                       P1 is the starting point and D1 is the ending point.
%                       0 <= t <= 1
%
%   <col>       (1,1)   color: 'r', 'b', etc..
%
%   <wid>       (1,1)   line width: 1, 2, 3, etc...
%
% Implementation:   Mohamed Mustafa, University of Manchester, February 2012
% Modifications:    March 2013:     remove the for-loop
%                   May 2013:       Works with 3D lines.
% -------------------------------------------------------------------------

% Default values
if nargin<3
    wid = 1;
    if nargin<2
        col = 'r';
    end
end

dim = size(LS,1)/2;     % dimension (2D or 3D)

% Extract information
P1 = LS(1:dim,:);           % Start Positions of Line Segments
P2 = P1 + LS(dim+1:end,:);  % Final positions of line segements

x1 = P1(1,:);       x2 = P2(1,:);
y1 = P1(2,:);       y2 = P2(2,:);

if dim==2       % for 2D
    line([x1;x2],[y1;y2],'color',col,'LineWidth',wid)
else            % for 3D
    z1 = P1(3,:);       z2 = P2(3,:);
    line([x1;x2],[y1;y2],[z1;z2],'color',col,'LineWidth',wid)
end
return


% % ====================================================
% % OLD IMPLEMENTATION
% % ====================================================
% function plotLineSegment(LS,col)
% % Plot Line segments
% %
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% % >>>>>>>> ONLY WORKS FOR 2D in the mean time >>>>>>>>>>>
% % >>>>> Check the source below for higher dimensions >>>>
% % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% % 
% % Input:
% %   <LS>        (4,N)   Array of dimension <2> and has <N> Line Segments in
% %                       the following format: P1 + t*D1
% %                       P1 is the starting point and D1 is the ending point.
% %                       0 <= t <= 1
% %
% %   <col>       (1,1)   color: 'r', 'b', etc..
% %
% % Implementation:   Mohamed Mustafa, University of Manchester, February 2012
% % Modifications:    March 2013:     remove the for-loop
% % -------------------------------------------------------------------------
% 
% % Default values
% if nargin<2
%     col = 'r';
% end
% % Extract elements
% P1 = LS(1:2,:);         % Start Positions of Line Segments
% P2 = P1 + LS(3:4,:);	% Final positions of line segements
% 
% x1 = P1(1,:);       x2 = P2(1,:);
% y1 = P1(2,:);       y2 = P2(2,:);
% line([x1;x2],[y1;y2],'color',col)
% return
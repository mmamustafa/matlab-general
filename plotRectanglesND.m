function h = plotRectanglesND(LL,UR,edgecolor,linestyle,facecolor)
% Plot Rectangles in 2D or 3D.
%
% Input:
%   <LL>        (2,N) or (3,N)  lower left corner points.
%
%   <UR>        (2,N) or (3,N)  upper right corner points.
%
% Implementation:   Mohamed Mustafa, University of Manchester, July 2015
% Modifications:    
% -------------------------------------------------------------------------

% Default values
if nargin<5
    facecolor = 'none';
    if nargin<4
        linestyle = '-';
        if nargin<3
            edgecolor = 'k';
            if nargin<2
                error('Bad Parameters!')
            end
        end
    end
end

dim = size(LL,1);	% dimension (2D or 3D)
if dim==2       % for 2D
    x = [LL(1,:);UR(1,:);UR(1,:);LL(1,:)];
    y = [LL(2,:);LL(2,:);UR(2,:);UR(2,:)];
    c = zeros(size(x));
    h = patch(x,y,c,'FaceColor',facecolor,'EdgeColor',edgecolor,'LineWidth',1,'LineStyle',linestyle);
elseif dim==3	% for 3D
    % fix z1 (face 1)
    x1 = [LL(1,:);UR(1,:);UR(1,:);LL(1,:)];
    y1 = [LL(2,:);LL(2,:);UR(2,:);UR(2,:)];
    z1 = repmat(LL(3,:),4,1);
    % fix z2 (face 2)
    x2 = [LL(1,:);UR(1,:);UR(1,:);LL(1,:)];
    y2 = [LL(2,:);LL(2,:);UR(2,:);UR(2,:)];
    z2 = repmat(UR(3,:),4,1);
    % fix y1 (face 3)
    x3 = [LL(1,:);UR(1,:);UR(1,:);LL(1,:)];
    z3 = [LL(3,:);LL(3,:);UR(3,:);UR(3,:)];
    y3 = repmat(LL(2,:),4,1);
    % fix y2 (face 4)
    x4 = [LL(1,:);UR(1,:);UR(1,:);LL(1,:)];
    z4 = [LL(3,:);LL(3,:);UR(3,:);UR(3,:)];
    y4 = repmat(UR(2,:),4,1);
    % fix x1 (face 5)
    y5 = [LL(2,:);UR(2,:);UR(2,:);LL(2,:)];
    z5 = [LL(3,:);LL(3,:);UR(3,:);UR(3,:)];
    x5 = repmat(LL(1,:),4,1);
    % fix x2 (face 6)
    y6 = [LL(2,:);UR(2,:);UR(2,:);LL(2,:)];
    z6 = [LL(3,:);LL(3,:);UR(3,:);UR(3,:)];
    x6 = repmat(UR(1,:),4,1);
    % put all together
    x = [x1 x2 x3 x4 x5 x6];
    y = [y1 y2 y3 y4 y5 y6];
    z = [z1 z2 z3 z4 z5 z6];
    c = zeros(size(x));
    h = patch(x,y,z,c,'FaceColor',facecolor,'EdgeColor',edgecolor,'LineWidth',1,'LineStyle',linestyle);
else
    error('Cannot plot dimensions other than 2D or 3D!')
end
return

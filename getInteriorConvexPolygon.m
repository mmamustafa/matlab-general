function [pts,a]  = getInteriorConvexPolygon(pts,ordered)
% Get the (almost) largest interior convex polygon given <pts>.
% Inputs:
%   <pts>       (2xN)   polygon vertices
%   <ordered>   (1x1)   boolean to identify if the points are ordered CCW.
%
% Output:
%   <pts>       (2xM)   convex vertices (M<=N)
%   <a>         (1x1)   convex polygon area
%
% Mohamed Mustafa, 2016
%
% >>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<
% >>>>>>>>> NOT COMLEPTE <<<<<<<<<
% >>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<

if nargin<2
    ordered = 0;    % points need ordering
end

% (1) Order the points if necessary
if ~ordered
    pts = sortPoints2D_CCW(pts);
end


N = size(pts,2);        % number of points
t1 = circshift(pts,[0 -1]) - pts;
t2 = atan2(t1(2,:),t1(1,:));
t2 = reduce_angle_fullCircle(circshift(t2,[0 -1]) - t2);    % difference between successive angles 

t3 = bwlabel(t2>0);     % connected components
% consider circular array
if t3(end)~=0,      t3(t3==t3(end)) = 1;        end
% shift arrays so the first element correseponds to the start of largest convex
% sequence.
t0 = max(t3);
if t0==1
    t0 = find(t3==0);
    steps = t0(end);
else
    steps = find(t3==t0)-1;
end
pts_temp = circshift(pts,[0 -steps]);
lbs_temp = circshift(t3,[0 -steps]);
ang_temp = circshift(t2,[0 -steps]);

t5 = rad2deg(ang_temp)
sum(t5(2:steps+1))
sum(t5(1:steps+1))-t5(1)




% start with largest convex sequence.
% if aggregate angle sum is more than 180, shift to left and start again
% (keep track of area)
% if angle change is negative, remove last points successively until
% convexity is achieved






% (2) Initalize ending indices
%     (starting index is always 1. shift points to maintain that).
ind_end = N;


% Polygon Area
a = polyarea(pts(1,:),pts(2,:));
return
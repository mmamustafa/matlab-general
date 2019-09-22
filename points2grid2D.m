function [M,LL,res] = points2grid2D(pts,res)
% Converts points in 2D to grid with resolution of <res> that always
% starts at the origin (0,0).
%
% Inputs:
%   <pts>   (2xN)   points in 2D
%   <res>   (1x1)   resolution
%
% Output:
%   <M>     (M1xM2) Binary matrix that represents the grid
%
% Mohamed Mustafa, 2016

if nargin<2
    res = 1e-2;
end

cells2LL = floor(min(pts,[],2)/res*1.2);	% number of cells to lower left corner
cells2UR = ceil(max(pts,[],2)/res*1.2);     % number of cells to upper right corner
LL = cells2LL*res;
UR = cells2UR*res;
n_xy = abs(cells2LL)+abs(cells2UR);         % number of cells in x and y, respectively
n_rc = flipud(n_xy);                        % number of rows and column, respectively
M = zeros(n_rc');                           % initialize the grid
% convert all points to row-columns
t1 = (pts - repmat(LL,1,size(pts,2)))./res;
rc = flipud(floor(t1 + eps(t1))+1);
rc = unique(rc','rows')';                   % get unique columns
ind = sub2ind(size(M),rc(1,:),rc(2,:));     % index in M
M(ind) = 1;
return
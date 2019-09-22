function [index,points,minDist,NumIntersections] = rayCast(ray, targets, type)
% -------------------------------------------------------------------------
% Ray Casting function to find the closest <target> the intersects with 
% <ray>.
%
% Usage:
%   [index,points,minDist,NumIntersections] = rayCast(ray, targets, type)
%
% Inputs:
%   <ray>           (4,N) or (6,N)  <N> rays in the following format [P0;D0]:
%                                   P0 + s*D0
%                                   P0 is the starting point and D0 is the 
%                                   direction. 0 <= s
%   <targets>       (4,M) or (6,M)  <M> targets:
%                                       - lines: in the following format: P1 + t*D1, -inf < t < inf
%                                       - planes: in point-normal format.
%                                       - lineSegments: in the following format: P1 + t*D1, 0 <= t <= 1
%                                         (P1 is starting point, D1 ending point)
%   <type>          (string)        'lines', 'planes', or 'lineSegments'.
%
% Outputs:
%   <index>         (1,N)           For each <ray>, choose one of <targets>
%                                   indecies that is the closeset {1:M}. If
%                                   no target is found, return 0.
%   <points>        (2,N) or (3,N)  Points of intersection at the closest
%                                   <targets>. If no intersection, return NaN.
%   <minDist>       (1,N)           minimum distance from center of <ray>
%                                   to closeset <target>.
%   <NumIntersections>  (1,N)       Number of intersection each <ray> makes
%                                   with different targets. This parameter 
%                                   is used for <isPointInsidePolygon> function.
%
% Implementation:   Mohamed Mustafa
%                   University of Manchester, September 2013
% Modifications:    ...
% -------------------------------------------------------------------------

% Default values
if nargin<3
    error('Bad parameters! See Help <rayCast>.')
end

Dim = size(ray,1)/2;    % dimension (2D or 3D)
N = size(ray,2);        % number of rays
M = size(targets,2);    % number of targets

if strcmp(type,'lineSegments')
    % repeat/rearrange <ray> and <targets> to have one command for
    % <intersection_ray_linSeg>.
    temp_ray = reshape(repmat(ray,M,1),2*Dim,[]);
    temp_targets = repmat(targets,1,N);
    temp_points = intersection_ray_lineSeg(temp_ray,temp_targets);
    
    % find the distance between <temp_points> and the center of <ray>
    P0 = temp_ray(1:Dim,:);
    dist = distance_point_point(temp_points,P0);
    
    % rearrange <dist> and find the minimum (column-wise)
    t1 = reshape(dist,M,[]);
    [minDist,index] = min(t1,[],1);
    
    % find corresponding <points> from <temp_points>
    temp_ind = M*[0:N-1] + index;
    points = temp_points(:,temp_ind);
    
    % replace values in <index> to 0 if corresponding <minDist> is not
    % finite.
    index(~isfinite(minDist)) = 0;
    
    % Compute the number of intersection for each <ray>
    if nargout>3
        NumIntersections = sum(isfinite(t1));
    end
elseif strcmp(type,'lines')
    % make sure everything in 3D because of <distance_line_line> function.
    if Dim<3
        ray = [ray(1:Dim,:);zeros(1,N);ray(Dim+1:end,:);zeros(1,N)];
        targets = [targets(1:Dim,:);zeros(1,M);targets(Dim+1:end,:);zeros(1,M)];
    end
    
    % repeat/rearrange <ray> and <targets> to have one command for
    % <distance_line_line>.
    temp_ray = reshape(repmat(ray,M,1),6,[]);
    temp_targets = repmat(targets,1,N);
    
    [dist,t1] = distance_line_line(temp_ray,temp_targets);
    
    % For all negative <t1> replace <dist> to INF.
    dist(t1<0) = inf;
    
    % Use <distance_point_line> to indecies with <dist> = 0 to reduce computations.
    ind1 = find(isEqual(dist,0));
    temp_points = temp_ray(1:3,ind1);
    temp_lines = temp_targets(:,ind1);
    [dist1,t1] = distance_point_line(temp_points,temp_lines);
    
    % create <dist> vector with all INF values except <ind1>
    dist = inf(1,M*N);
    dist(ind1) = dist1;
    temp_t = inf(1,M*N);
    temp_t(ind1) = t1;
    
    % rearrange <dist> and find the minimum (column-wise)
    t1 = reshape(dist,M,[]);
    [minDist,index] = min(t1);
    
    % find corresponding <points> from <temp_t>
    temp_ind = M*[0:N-1] + index;
    points = repmat(temp_t(:,temp_ind),3,1).*temp_targets(4:6,temp_ind) + temp_targets(1:3,temp_ind);
    
    % replace values in <index> to 0 if corresponding <minDist> is not finite.
    index(~isfinite(minDist)) = 0;
    
    if Dim<3
        points = points(1:Dim,:);   % make <points> 2D
    end
    
    % Compute the number of intersection for each <ray>
    if nargout>3
        NumIntersections = sum(isfinite(t1));
    end
elseif strcmp(type,'planes')
    % >>> Do this later >>>
    % ...
else
    error('<type> is not supported!')
end

return

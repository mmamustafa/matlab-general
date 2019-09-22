function point = intersection_line_plane(line,plane)
% -------------------------------------------------------------------------
% Usage:
%       [point] = line_plane_intersection(line,P)
%
% Inputs:
%       <line>      (6XM) Lines with the following format:   r0 + t*v0
%       <plane>     (6XM) planes in the point-normal format
%
% Outputs:
%       <point>     (3XM) points of intersection
% 
% Source:           http://local.wasp.uwa.edu.au/~pbourke/geometry/planeline/
%                   http://softsurfer.com/Archive/algorithm_0104/algorithm_0104B.htm
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, September 2009
% -------------------------------------------------------------------------

n = plane(4:6,:);  % extract normal from Planes
t = dot(n,plane(1:3,:)-line(1:3,:))./dot(n,line(4:6,:));
point = line(1:3,:) + repmat(t,3,1).*line(4:6,:);
return
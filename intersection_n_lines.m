function P = intersection_n_lines(L)
% -------------------------------------------------------------------------
% Intersection of N lines to one point using least squares.
%
% Usage:
%       P = intersection_n_lines(L)
%
% Inputs:
%       <L>         (4XM) or (6XM) Lines with the following format:   p + t*v
%
% Outputs:
%       <P>         (2X1) or (3X1) point of intersection
% 
% Source:
%                   http://en.wikipedia.org/wiki/Line-line_intersection
%
% Implementation:   Mohamed Mustafa
%                   University of Manchester, May 2013
% -------------------------------------------------------------------------

dim = size(L,1)/2;      % dimension of the lines
NL = size(L,2);         % number of lines

% Extract points and direction of <L>
p = L(1:dim,:);                     % points
v = unit_vector(L(dim+1:end,:));    % directions should be unit vectors

% >>>>>>>>>>>>>>>>>>>>>>
% >>> not efficient but fix later...
% >>>>>>>>>>>>>>>>>>>>>>
t1 = zeros(dim);        t2 = zeros(dim,1);
for i=1:NL
    x = eye(dim) - v(:,i)*v(:,i)';
    t1 = t1 + x;
    t2 = t2 + x*p(:,i);
end
% exception when lines are parallel (or only one line is in <L>)
if isfinite(cond(t1))   % Eveything is OK
    P = t1\t2;
else                    % Exception for parallel lines
    P = mean(p,2);
end
return

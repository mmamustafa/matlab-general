function h = plotPoints(P,col,msize)
% Plot points.
% 
% plotPoints(P,col,msize)
%
% Works in 2D and 3D
%
% Input:
%   <P>         (2,N) or (3,N)  Array of dimension <2> or <3> and has <N>
%                               points.
%
%   <col>       (1,1)   color: 'r', 'b', etc...
%
%   <msize>     (1,1)   marker size: 10, 12, etc..
%
% Implementation:   Mohamed Mustafa, University of Manchester, May 2013
% Modifications:    
% -------------------------------------------------------------------------

% Default values
if nargin<3
    msize = 5;
    if nargin<2
        col = 'r.';
    end
end

dim = size(P,1);	% dimension (2D or 3D)
x = P(1,:);
y = P(2,:);

if dim==2       % for 2D
    h = plot(x,y,col,'MarkerSize',msize);
else            % for 3D
    z = P(3,:);
    h = plot3(x,y,z,col,'MarkerSize',msize);
end
return

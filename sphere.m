% sphere
% -----------------------------------------------------------------------
%   sphere(X0,r,c_p) plots circles with center
%   at X0 and radius of r.
%   X0 = [x0 y0 z0]'
%   r  = vector of radii
%   p = plot or not (1, 0)
%   c_p = color/pointer.  e.g. 'b.' == blue with dots,
%                              'r*' == red with stars
%         Default is Blue with dots.
% -----------------------------------------------------------------------

function pts = sphere(X0,r,p,c_p)
if nargin<4
    c_p = 'b.';
    if nargin<3
        p = 0;
        if nargin<2
            error('Bad Parameters!');
        end
    end
end
parts = 1;  % 1 = full circle, 2 hemisphere, 4 = 1/4th of sphere, 8 = 1/8th of sphere

if parts==1 || parts==2
    theta =	0:0.1:pi;
    phi =	0:0.1:pi/2;
end

x = []; y = []; z = [];
for i=1:length(phi)
    for j=1:length(theta)
        x = [x r.*cos(phi(i)).*cos(theta(j))+X0(1,:)];
        y = [y r.*cos(phi(i)).*sin(theta(j))+X0(2,:)];
        z = [z r.*sin(phi(i))+X0(3,:)];
    end
end

if p==1
    plot3(x,y,z,c_p);
end

if nargout>0
    pts = [x;y;z];
end
return
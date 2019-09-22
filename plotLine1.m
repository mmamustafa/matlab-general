function plotLine1(w,d,col,wid,style)
% Plot line 2D. L is in HNF
% -------------------------------------------------------------------------

if nargin<5
    style = '-';
    if nargin<4
        wid = 1;
        if nargin<3
            col = 'k';
        end
    end
end

w = unit_vector(w);

% (1) find the closest point on the line to the origin.
p0 = -w*d;

% (2) rotate w 90 degrees
dir = rot2D(pi/2)*w;

% (3) get two points in the line
t = 1e2;
p1 = p0 - t*dir;
p2 = p0 + t*dir;

% (4) plot the line segment
x = [p1(1) p2(1)];
y = [p1(2) p2(2)];
plot(x,y,[col style],'LineWidth',wid);

return

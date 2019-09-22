function pts = plotEllipse(c,a,b,alpha,col,sz)
% plot circle function
%
% Inputs:
%   <c>     center of ellipse
%   <a>     major axis distance
%   <b>     minor axis distance
%   <alpha> angle between x-axis and major axis
%   <col>   color of the line
%   <sz>    size of the line
%
% https://en.wikipedia.org/wiki/Ellipse
% Mohamed Mustafa, 2016

if nargin<6
    sz = 1;
    if nargin<5
        col = 'k-';
        if nargin<4
            alpha = 0;
            if nargin<3
                b = 0.5;
                if nargin<2
                    a = 1;
                    if nargin<1
                        c = [0 0]';
                    end
                end
            end
        end
    end
end
if isempty(col)
    col = 'k-';
end

th = 0:1e-2:2*pi;
x = c(1) + a*cos(th)*cos(alpha) - b*sin(th)*sin(alpha);
y = c(2) + a*cos(th)*sin(alpha) + b*sin(th)*cos(alpha);
plot(x,y,col,'LineWidth',sz);
if nargout>0
    pts = [x;y];
end
return
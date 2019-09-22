function pts = kidneyShape(r0,xm,ym,times2)
% Kidney shaped set at  origin.
%
% Inputs:
%   <r0>    radius (max distance from origin)
%   <xm>    xm<r0   x deviation
%   <ym>    ym<r0   y deviation
%   <times1> mirror image about y-axis
%
% Mohamed Mustafa, 2016

if nargin<4
    times2 = 1;
    if nargin<3
        ym = 1.5;
        if nargin<2
            xm = 1.0;
            if nargin<1
                r0 = 2;
            end
        end
    end
end

% sanity check
if abs(xm)>= r0
    xm = r0/2;
end
if abs(ym)>= r0
    ym = 0.75*r0;
end

% Section (1)
% -----------
x_shift = 0.2*xm;
% curve fitting
A = [0 0 0 1;                           % y = ax^3 + bx^2 + cx + d
    ym^3 ym^2 ym 1;                     % y = ax^3 + bx^2 + cx + d
    (ym/2)^3 (ym/2)^2 (ym/2) 1;         % y = ax^3 + bx^2 + cx + d
    3*ym^2 2*ym 1 0];                   % y'= 3ax^2 + 2bx + c
b = [x_shift xm x_shift+(xm-x_shift)/2 0]';
p = A\b;        % parameters:  x = f(y)

y1 = 0:1e-2:ym;
x1 = p'*[y1.^3;y1.^2;y1;y1.^0];

% Section (2)
% -----------
xc = 0;     yc = ym;        % center if ellipse
a = xm;     b = r0-ym;      % ellipse parameters

th = 0:1e-2:pi/2;
x2 = xc + a*cos(th);
y2 = yc + b*sin(th);

% Section (3)
% -----------
if times2==1
    th = pi/2:1e-2:pi;
    r = r0*ones(size(th));
    x3 = r.*cos(th);
    y3 = r.*sin(th);
else
    x3 = -fliplr([x1 x2]);
    y3 = fliplr([y1 y2]);
end

% All together
% ------------
x = [x1 x2 x3;y1 y2 y3];
x_hat = fliplr(x);
x_hat(2,:) = -x_hat(2,:);
pts = [x x_hat];



return
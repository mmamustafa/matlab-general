% Rectangle
% Input format:
%   [x1 x2 x3 ...]      % x values
%   [y1 y2 y3 ...]      % y values
%   [h1 h2 h3 ...]      % height
%   [w1 w2 w3 ...]      % width
%   [t1 t2 t3 ...]      % theta with respect to +ve x-axis
%       
% if w or h is negative, be careful as the output will be rotated or
% fliped.
function pts = rectangles(arg,clr)
if nargin<2
    clr = 'b';
end

n = size(arg,2);  % number of rectangles
x = arg(1,:);
y = arg(2,:);
w = arg(3,:);
h = arg(4,:);
if size(arg,1)<5
    theta = zeros(1,n);
else
    theta = arg(5,:);
end
p1 = zeros(2,n);
p2 = [w;zeros(1,n)];
p3 = [w;h];
p4 = [zeros(1,n);h];

for i=1:n
    R = [cos(theta(i)) -sin(theta(i));sin(theta(i)) cos(theta(i))];
    T = repmat([x(i);y(i)],1,5);
    temp(:,:,i) = R*[p1(:,i) p2(:,i) p3(:,i) p4(:,i) p1(:,i)] + T;
    line(temp(1,:,i),temp(2,:,i),'color',clr,'LineWidth',2)
end
if nargout>1
    pts = temp;
end
hold off
axis equal
return
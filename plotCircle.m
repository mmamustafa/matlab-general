function pts = plotCircle(c,r,col,sz)
% plot circle function
% Mohamed Mustafa, 2016

if nargin<4
    sz = 1;
    if nargin<3
        col = 'k-';
        if nargin<2
            r = 1;
            if nargin<1
                c = [0 0]';
            end
        end
    end
end
if isempty(col)
    col = 'k-';
end

th = 0:1e-2:2*pi;
x = c(1) + r*cos(th);
y = c(2) + r*sin(th);
plot(x,y,col,'LineWidth',sz);
if nargout>0
    pts = [x;y];
end
return
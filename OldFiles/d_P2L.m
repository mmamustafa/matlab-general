function dist = d_P2L(L,P)
% Distance between a point and line in 2D/3D space.
% Usage:    dist = d_P2L(L,P)
% Inputs:
%         - L: Lines in 3D in following format:   r + t*v
%           [r1 r2 r3 ...]      % 3 X N matrix
%           [v1 v2 v3 ...]      % 3 X N matrix   (both 6 X N matrix)
%         - L: Lines in 2D in following format:   b + mx
%           [m1 m2 m3 ...]      % 1 X N matrix
%           [b1 b2 b3 ...]      % 1 X N matrix   (both 2 X N matrix)
%
%         - P: Points in 3D in following format:
%           [X1 X2 X3 ...]      % 3 X N matrix {x,y,z}
%         - P: Points in 2D in following format:
%           [X1 X2 X3 ...]      % 2 X N matrix {x,y}
%
% Outputs:
%         - dist:   [d1 d2 d3 ...]
% 
% Source:   http://mathworld.wolfram.com/Point-LineDistance3-Dimensional.html
%           http://www.coventry.ac.uk/ec//jtm/slides/8/sld8p5.pdf
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, September 2009
%
if nargin<2
    error('Bad Parameters!');
end
if size(L,2)~=size(P,2)
    error('L & P should have same number of columns!');
end

if size(P,1)==2
    % 2D
    % chaneg [m b] to [a b c], where ax + by + c = 0
    a = L(1,:);
    b = -ones(1,length(a));
    c = L(2,:);
    dist = abs(a.*P(1,:) + b.*P(2,:) + c)./sqrt(a.^2+b.^2);
elseif size(P,1)==3
    % 3D
    a = L(1:3,:);
    b = L(4:6,:);
    d_P = P-a;
    dist = sqrt(dot(d_P,d_P)-(dot(d_P,b).^2)./sum(b.^2));
else
    error('P should have number of rows equal to 2 or 3!');
end
return
function [dist,t] = distance_point_line(P,L)
% -------------------------------------------------------------------------
% Distance between a point and line in 2D & 3D spaces.
% 
% Usage:
%       [dist,t] = distance_point_line(P,L)
%
% Inputs:
%       <P>         (2XM) or (3XM) Points in 2D or 3D 
%       <L>         (4XM) or (6XM) Lines in 2D or 3D in the following format: r0 + t*v0
%
% Outputs:
%       <dist>      (1XM) Distance
%       <t>         (1XM) parameter on <L> where projection of <P> occurs
% 
% Source:           http://mathworld.wolfram.com/Point-LineDistance3-Dimensional.html
%                   (uses cross product which is slow)
%                   http://www.coventry.ac.uk/ec//jtm/slides/8/sld8p5.pdf
%                   (uses dot product, which is 10 times faster than first source)
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, October 2009
% -------------------------------------------------------------------------
if nargin<2
    error('Bad Parameters!');
end
if size(L,2)~=size(P,2)
    error('L & P should have same number of columns!');
end
if size(L,1)/2~=size(P,1)
    error('Row dimensions do not match! Use "help distance_point_line".');
end

if size(P,1)==2
    % Make 2D problem 3D problem to ease on calculations.
    z = zeros(1,size(P,2));
    P = [P;z];          L = [L(1:2,:); z; L(3:4,:); z];
end
    
a = L(1:3,:);           b = L(4:6,:);           d_P = P-a;
dist = sqrt(dot(d_P,d_P)-(dot(d_P,b).^2)./sum(b.^2));
if nargout>1
    t = dot(d_P,b)./sum(b.^2);  % parameter of projection of P on L
end
return
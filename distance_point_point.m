function dist = distance_point_point(P1,P2,sq)
% -------------------------------------------------------------------------
% Distance between two points in 2D or 3D spaces.
% 
% Usage:
%       [dist] = distance_point_point(P1,P2)
%
% Input:
%       <P1>        (2XM) or (3XM) First set of points in 2D or 3D
%       <P2>        (2XM) or (3XM) Second set of points in 2D or 3D
%       <sq>        (1X1) 1/0:with/without square-root (Optional)
%                         Default = 1
%
% Output:
%       <dist>      (1XM) distance between P1 & P2
% 
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, November 2009
% -------------------------------------------------------------------------
if nargin<3
    sq = 1;     % to decide whether to take square-root or not
    if nargin<2
        error('Bad Parameters!');
    end
end
if size(P1,2)~=size(P2,2)
    error('P1 & P2 should have same number of columns!');
end
    
dist = sum((P1-P2).^2,1);
if sq==1
    dist = sqrt(dist);
end
return
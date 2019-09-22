function plane_hnf = plane_pn2hnf(plane_pn)
% -------------------------------------------------------------------------
% Plane form function:
% General Form --> Hessian Normal Form:  n.x + d = 0,   d >= 0 
% 
% Inputs:
%       <plane_pn>  (6XM) planes in point-normal format.
%
% Output:
%       <plane_hnf> (4XM) planes in Hessian Normal Form (n,d)
%
% Mohamed Mustafa
% University of Manchester, November 2015
% -------------------------------------------------------------------------

n = unit_vector(plane_pn(4:6,:));	% unit normal
d = -sum(plane_pn(1:3,:).*n);       % signed distance to origin

% Make sure that <d> is always positive
ind = d<0;
d(ind) = -d(ind);
n(:,ind) = -n(:,ind);

% Form the plane
plane_hnf = [n;d];
return
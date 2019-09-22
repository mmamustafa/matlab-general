function hyperplane_hnf = hyperplane_pn2hnf(hyperplane_pn)
% -------------------------------------------------------------------------
% Hyperplane transform:
% General Form --> Hessian Normal Form:  n.x + d = 0,   d >= 0 
% 
% Inputs:
%       <hyperplane_pn>  (2D x M) planes in point-normal format.
%
% Output:
%       <hyperplane_hnf> (D+1 x M) planes in Hessian Normal Form (n,d)
%
% Mohamed Mustafa
% University of Manchester, November 2015
%                           May 2016
% -------------------------------------------------------------------------

D = size(hyperplane_pn,1)/2;                    % dimensions

n = unit_vector(hyperplane_pn(D+1:2*D,:));      % unit normal
d = -sum(hyperplane_pn(1:D,:).*n);              % signed distance to origin

% Make sure that <d> is always positive
ind = d<0;
d(ind) = -d(ind);
n(:,ind) = -n(:,ind);

% Form the plane
hyperplane_hnf = [n;d];
return
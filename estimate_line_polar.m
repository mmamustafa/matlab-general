function [L] = estimate_line_polar(X)
% -------------------------------------------------------------------------
% >>>>>> NEW FASTER FUNCTION IS AVAILABLE <<<<<<<<<<<<
% >>>>>> estimate_line_polar_2 <<<<<<<<<<<<<<<<<<<<<<<
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% Estimate line parameters from point cloud where points are represented in
% polar coordinate (r,theta). The estimated line is also represented in
% polar form (rho,alpha).
% 
% It works in ONLY 2D data. All angles are in radian.
% 
% This function is used, instead of PCA method, when the noise is normally
% distributed in the range readings (r's). If PCA is used the result will
% be biased since it requires the noise to be perpendicular to the
% estimated line!
% 
% In this Implementation, it is assumed that the uncertainty in INDEPENDENT
% of the distance. Which means all w_i are equal for different i values.
% Refer to Intro. to Autonomous Mobile Robots. Pages 156-157.
% 
% Formulas are from Intro. to Autonomous Mobile Robots. Page 157
%
% Inputs:
%   <X>         (2,N)   Points cloud in polar form:
%                       - First row represents range <r>
%                       - Second row represents angel <t>
%
% Outputs:
%   <L>         (2,1)   Best fit line in polar form (rho,alpha)
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

if nargin<1
    error('Bad Parameters!');
end

% Extract <r> and <t> from <X>
r = X(1,:);         t = X(2,:);

T = length(r);      % number of points

temp = repmat(t,length(t),1);       % used to compute: cos(t_i + t_j) in <d_x>
d_y = sum(r.*r.*sin(2*t)) - 2/T*sum(sum((r.*cos(t))'*(r.*sin(t))));
d_x = sum(r.*r.*cos(2*t)) - 1/T*sum(sum((r'*r).*cos(temp+temp')));

alpha = 0.5*atan2(d_y,d_x)+pi/2;    % pi/2 is not in the book's formula, but experiment showed it works this way
rho = 1/T*sum(r.*cos(t-alpha));

% To make sure <rho> is always positive
if rho<0
    rho = abs(rho);
    alpha = alpha+pi;
end

L = [rho alpha]';
return

function [L] = estimate_line_polar_2(X)
% -------------------------------------------------------------------------
% Estimate line parameters from point cloud where points are represented in
% polar coordinate (r,theta). The estimated line is also represented in
% polar form (rho,alpha).
% 
% It works in ONLY 2D data. All angles are in radian.
% 
% This function is used, instead of PCA method, when the noise is normally
% distributed in the range readings (r's). If PCA is used, the result will
% be biased since it requires the noise to be perpendicular to the
% estimated line!
% 
% In this Implementation, it is assumed that the uncertainty is INDEPENDENT
% of the distance, which means all w_i are equal for different i values.
% Refer to Intro. to Autonomous Mobile Robots. Pages 156-157.
% 
% Formulas are from internet, google: Feature Extraction and Scene 
% Interpretation for Map-Based Navigation and Map Building.
%
% Inputs:
%   <X>         (2N,M)  Points cloud in polar form:
%                       - 1:N rows represents range <r>
%                       - N+1:2N rows represents angel <t>
%                       - M represnets number of samples. (ONLY used to
%                         calculate the jacobian for the covariance matrix)
%
% Outputs:
%   <L>         (2,M)   Best fit lines in polar form (rho,alpha)
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

if nargin<1
    error('Bad Parameters!');
end

% Extract paramters from <X>
M = size(X,2);          % number of samples
T = size(X,1)/2;        % number of points in the cloud;
r = X(1:T,:);           % ranges
t = X(T+1:2*T,:);       % angles

% Convert <t> & <r> tp <x> & <y>
[x,y] = pol2cart(t,r);

% Compute the average of <x> & <y>
x_ = 1/T*sum(r.*cos(t));
y_ = 1/T*sum(r.*sin(t));

% Repeat <x_> & <y_> for dimension matching with <x> & <y>
x_rep = repmat(x_,T,1);
y_rep = repmat(y_,T,1);

% Compute <alpha> & <rho>
d_y = -2*sum((y_rep-y).*(x_rep-x));
d_x = sum((y_rep-y).^2 - (x_rep-x).^2);
alpha = 0.5*atan2(d_y,d_x);
rho = x_.*cos(alpha) + y_.*sin(alpha);

% To make sure <rho> is always positive
ind = find(rho<0);
rho(ind) = abs(rho(ind));
alpha(ind) = alpha(ind) + pi;

% Return the output
L = [rho;alpha];

return

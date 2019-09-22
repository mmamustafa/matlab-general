function [L] = estimate_line_polar_3(X,W)
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
% https://e-collection.library.ethz.ch/eserv.php?pid=eth:8401&dsID=eth-8401-01.pdf
%
% Inputs:
%   <X>         (2N,M)  Points cloud in polar form:
%                       - 1:N rows represents range <r>
%                       - N+1:2N rows represents angel <t>
%                       - M represnets number of samples. (ONLY used to
%                         calculate the jacobian for the covariance matrix)
%   <W>         (N,1)   weight of each range measurement
%
% Outputs:
%   <L>         (2,M)   Best fit lines in polar form (rho,alpha)
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
%                                   November 2016: Weighted least squares.
% -------------------------------------------------------------------------

if nargin<1
    error('Bad Parameters!');
end

% Extract paramters from <X>
M = size(X,2);          % number of samples
N = size(X,1)/2;        % number of points in the cloud;
r = X(1:N,:);           % ranges
t = X(N+1:2*N,:);       % angles

SW = sum(W);            % sum of weights (column-wise)
% Make sure <W> has the same dimension as <r> and <t>
W = repmat(W,1,M);

% Convert <t> & <r> tp <x> & <y>
[x,y] = pol2cart(t,r);

% comput <x_bar> and <y_bar>
x_bar = sum(W.*x)/SW;
y_bar = sum(W.*y)/SW;

% repeat <x_bar> and <y_bar> row-wise to match the size of <x> and <y>
x_bar_rep = repmat(x_bar,N,1);
y_bar_rep = repmat(y_bar,N,1);

% compute <alpha> & <rho>
dy = -2*sum(W.*(y_bar_rep - y).*(x_bar_rep - x));
dx = sum(W.*( (y_bar_rep - y).^2 - (x_bar_rep - x).^2 ));
alpha = 0.5*atan2(dy,dx);
rho = x_bar.*cos(alpha) + y_bar.*sin(alpha);

% To make sure <rho> is always positive
ind = find(rho<0);
rho(ind) = abs(rho(ind));
alpha(ind) = alpha(ind) + pi;

% Return the output
L = [rho;alpha];

return







% % ------------------ Old Implementation ----- Start ---------------------
% % Compute quantities that are used more than once
% r2 = r.^2;
% 
% % The sum should always be column-wise (i.e. add columns)
% S1 = sum(W.*r2.*sin(2*t));  % vector (1xM)
% S3 = sum(W.*r2.*cos(2*t));  % vector (1xM)
% 
% S2_ = zeros(size(S1));
% S4_ = S2_;
% for i=1:N
%     wi = W(i,1);    % scalar
%     ri = r(i,:);    % vector (1xM)
%     ti = t(i,:);    % vector (1xM)
%     % make dimensions similar of <ri>
%     ri = repmat(ri,N,1);
%     ti = repmat(ti,N,1);
%     % update S2_
%     S2_(i,:) = sum(wi.*W.*ri.*r.*cos(ti).*sin(t));
%     % update S4_
%     S4_(i,:) = sum(wi.*W.*ri.*r.*cos(ti+t));
% end
% S2 = 2/SW*sum(S2_);     % vector (1xM)
% S4 = 1/SW*sum(S4_);     % vector (1xM)
% 
% alpha = 0.5*atan2(S1-S2,S3-S4) + pi/2;     % vector (1xM)
% rho = sum(W.*r.*cos(t - repmat(alpha,N,1)))/SW;
% % ------------------ Old Implementation ----- End -----------------------


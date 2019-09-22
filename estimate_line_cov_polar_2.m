function C_ra = estimate_line_cov_polar_2(X,rhoCov,thetaCov)
% -------------------------------------------------------------------------
% This function computes the covariance of the estimated line from polar
% points.
% 
% Reference: Intro. to Autonomous Mobile Robots, Page 159
%
% Inputs:
%   <X>         (2N,1)  Points cloud in polar form: [r;t]
%   <rhoCov>    (N,1)   range covariance of each point
%   <thetaCov>  (N,1)   angle covariance of each point
%
% Outputs:
%   <C_ra>      (2,2)   Covariance of the estimated line in <rho> and <alpha>
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

N = size(X,1)/2;            % number of points

if nargin<3
    thetaCov = zeros(N,1);
    if nargin<2
        rhoCov = thetaCov;
        if nargin<1
            error('Bad Parameters!');
        end
    end
end

if length(rhoCov)==1
    rhoCov = rhoCov*ones(N,1);
end

% Compute covariance matrix of the points (2N X 2N)
C_x = diag([rhoCov;thetaCov]);

% Compute Jacobian
F = getJacobian('estimate_line_polar_2',X);

% Compute the covariance of the line
C_ra = F*C_x*F';
return

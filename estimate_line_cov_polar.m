function C_ra = estimate_line_cov_polar(X,rhoCov,thetaCov)
% -------------------------------------------------------------------------
% This function computes the covariance of the estimated line from polar
% points.
% 
% Reference: Intro. to Autonomous Mobile Robots, Page 159
%
% Inputs:
%   <X>         (2,N)   Points cloud in polar form: [r;t]
%   <rhoCov>    (1,N)   range covariance of each point
%   <thetaCov>  (1,N)   angle covariance of each point
%
% Outputs:
%   <C_ra>      (2,2)   Covariance of the estimated line in <rho> and <alpha>
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

N = size(X,2);      % number of points

if nargin<3
    thetaCov = zeros(1,N);
    if nargin<2
        rhoCov = thetaCov;
        if nargin<1
            error('Bad Parameters!');
        end
    end
end

if length(rhoCov)==1
    rhoCov = rhoCov*ones(1,N);
end

% Compute covariance matrix of the points (2N X 2N)
C_x = diag([rhoCov,thetaCov]);

% Compute Jacobian
r = X(1,:)';
t = X(2,:)';
F = getJacobian('estimate_lines_polar',[r;t]);

% Compute the covariance of the line
C_ra = F*C_x*F';
return

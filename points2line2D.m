function L = points2line2D(X)
% -------------------------------------------------------------------------
% Point cloud to line function in 2D.
% 
% Similar to <estimate_line> function where PCA and SVD are used.
%
% Only develoved for 2D to allow computation of covariance matrix when
% uncertainty is polar.
%
% Input:
%   <X>         (2N,M)  Points cloud in cartesian form:
%                       - 1:N rows represents <x>
%                       - N+1:2N rows represents <y>
%                       - M represnets number of samples. (ONLY used to
%                         calculate the jacobian for the covariance matrix)
%
% Output:
%   <L>         (4XM)   Best fit line with the normal (polar) format
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, October 2009
% Modifications:    April 2013
% -------------------------------------------------------------------------

if nargin<1
    error('Bad Parameters!');
end
if size(X,1)<4
    error('Infinite number of lines go thru one point! Two or more points are required!');
end

% Extract paramters from <X>
M = size(X,2);          % number of samples
T = size(X,1)/2;        % number of points in the cloud;
rho = X(1:T,:);           % rho-values
theta = X(T+1:2*T,:);       % theta-values
x = rho.*cos(theta);
y = rho.*sin(theta);


% Use a for-loop (not efficient but fix later)
L = [];
for i=1:M
    temp = [x(:,i), y(:,i)]';
    L = [L estimate_line(temp)];
end
L = line2D_pd2nf(L);
return

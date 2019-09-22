function [L] = estimate_lines_polar(X,C)
% -------------------------------------------------------------------------
% This function uses <estimate_line_polar> multiple times to estimate
% several lines. The major reason for designing this function is to compute
% the jacobain numerically using <getJacobian> function, which requires the
% ability to evaulate MIMO functions.
%
% We use for-loop with the basic <estimate_line_polar> function and
% aggregate the reults.
%
% The input <X> to this function is different than the input to the basic
% <estimate_line_polar> in the sense that <r> and <t> are in a single
% column vector in <estimate_lines_polar>, whereas in
% <esitmate_line_polar>, <r> and <t> are in different rows. Read inputs
% below.
%
% This function will only work in 2D.
%
% Inputs:
%   <X>         (2N,M)  Points cloud in polar form:
%                       - Each column is [r;t]
%
% Outputs:
%   <L>         (2,M)   Best fit lines in polar form (rho,alpha) for each
%                       column in <X>
%
% Implementation:   Mohamed Mustafa, University of Manchester, January 2012
% -------------------------------------------------------------------------

if nargin<1
    error('Bad Parameters!');
end

M = size(X,2);      % number of samples (lines)
N = size(X,1)/2;    % number of points in each lines 
L = [];
for i=1:M
    r = X(1:N,i)';      % ranges of points
    t = X(N+1:end,i)';  % angles of points
    L = [L, estimate_line_polar([r;t])];
end
return

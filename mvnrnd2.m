function r = mvnrnd2(mu,Sig,n)
% -------------------------------------------------------------------------
% Generate random vectors from a multivariate normal distribution defined
% by mean vector <mu> and covariance matrix <Sig>
%
% Inputs:
%   <mu>    (1 X d)     Mean vector (d is dimensions)
%   <Sig>   (d x d)     Covariance matrix
%   <n>     (1 x 1)     Number of points to generate
%
% Output:
%   <r>     (n x d)     Output vector, each row is a sample.
%
% Mohamed Mustafa, The University of Manchester. February 2017.
% -------------------------------------------------------------------------

if nargin<3
    n = 1;
end

[nr,nc] = size(mu);
if nr>1
    mu = mu';
end

T = cholcov(Sig);
if isempty(T)
    r = repmat(mu,n,1);
else
    r = (repmat(mu',1,n) + T'*randn(size(mu,2),n))';
end
return
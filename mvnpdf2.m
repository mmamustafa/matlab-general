function y = mvnpdf2(x,u,S)
% Multivariate normal probability density function for degenerate case were
% the convariance matrix <S> is rank deficient.
%
% If <S> if positive definite matrix, use built-in function <mvnpdf>.
%
% Inputs:
%   <x>     (d x n)     <n> samples in <d> dimensional space.
%   <u>     (d x 1)     Mean of the distribution.
%   <S>     (d x d)     Covariance matrix of the distribution.
%                       It can be rank deficient.
%
% Outputs:
%   <y>     (1 x n)     Probability density function of each sample <n>.
%
% Implementation:   Mohamed Mustafa, University of Manchester, Novemeber 2013
% Modifications:    ...
%
% Source:
%   http://www.stat.duke.edu/~km68/materials/214.3%20(MVN%20Theory).pdf
% -------------------------------------------------------------------------

n = size(x,2);      % number of samples

% Eigenvalues of <S> cannot be negative becuase <S> can be positive
% semi-definite in the degenerate case.
[Vt,Dt] = eig(S);

% Get all positive eigenvalues and their corresponding eigenvectors of <S>.
Dt = diag(Dt);      % matrix --> vector
ind = Dt>0;
D = Dt(ind);        % positive eigenvalues
V = Vt(:,ind);      % eigenvectors corresponding to positive eigenvalues
k = size(D,1);      % number of positive eigenvalues

if ~isempty(D)
    % Find the pseudo-inverse of <S>
    V_ = V*diag(1./D)*V';

    % Mahalanobis distance
    u = repmat(u,1,n);
    Q = diag((x-u)'*V_*(x-u))';     % for large number of sample, maybe it is better to use for-loop (try and evaluate later...)

    % Normalizer
    N = 1/sqrt((2*pi)^k*prod(D));

    % pdf
    y = N.*exp(-Q/2);
else
    ind = isEqual(sum((x-repmat(u,1,n)).^2),0);
    y = zeros(1,n);
    y(ind) = 1;
end
return
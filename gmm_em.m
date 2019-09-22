function [C,gamma] = gmm_em(X,K,flag,toPlot)
% Expectation Maximization for Gaussian Mixture Models
% Reference: 
%     http://www.ics.uci.edu/~smyth/courses/cs274/notes/EMnotes.pdf
%     http://www.cse.psu.edu/~rtc12/CSE586Spring2010/papers/prmlMixturesEM.pdf
%     http://mlg.eng.cam.ac.uk/tutorials/06/cb.pdf
% -------------------------------------------------------------------------
%
% Variables:
%   <d>     space dimension
%   <N>     total number of data points
%   <n>     index of data point
%   <K>     total number of clusters
%   <k>     index of cluster
%   <C>     Cell array (1 x K): each cell is Clusters (data structure):
%           <u>     (d x 1)     mean
%           <S>     (d x d)     covariance
%           <p>     (1 x 1)     mixing coefficient
%
% Mohamed Mustafa, UoM, 2016
% -------------------------------------------------------------------------

if nargin<4
    toPlot = 0;
    if nargin<3
        flag = 0;   % 0 = use kmeans for initialization
                    % 1 = use random means for initialization
    end
end

% (1) Extract information
[d,N] = size(X);

% (2) Initialize
X_min = min(X,[],2);
X_max = max(X,[],2);
WL = reshape([X_min X_max]',[],1)';
if flag==0
    [~,C0] = kmeans(X',K);
    u_all = C0';
elseif flag==1
    u_all = uniSampleND(WL,K);
end

C = cell(1,K);
for k=1:K
    C{k}.u = u_all(:,k);
    C{k}.S = eye(d);
    C{k}.p = 1/K;
end
gamma = zeros(N,K);         % responsibility matrix
stop = 0;
i = 0;

while ~stop
    % (a) Expectation Step:     update all responsibilities
    for k=1:K
        gamma(:,k) = C{k}.p*mvnpdf(X',C{k}.u',C{k}.S);
    end
    den = sum(gamma,2);
    gamma = gamma./repmat(den,1,K);

    % (b) Maximization Step:    update the model parameters
    N_k_all = sum(gamma);
    for k=1:K
        N_k = N_k_all(k);
        % Mean
        t1 = repmat(gamma(:,k)',d,1);
        C{k}.u = sum(t1.*X, 2)/N_k;
        % Covariance
        C{k}.S = zeros(d);              % initialize covariance
        for n=1:N
            t1 = X(:,n) - C{k}.u;
            C{k}.S = C{k}.S + gamma(n,k)*(t1*t1');
        end
        C{k}.S = C{k}.S/N_k;
        % Mixing Coefficent
        C{k}.p = N_k/N;
    end
    % (c) Check the convergence condition
    v = sum(log(den));
    if i~=0
        if abs(v-v_old)<1e-2
            stop = 1;
        end
    end
    i = i+1;
    v_old = v;
    
    % Plotting
    if toPlot>0 && d<4
        figure(toPlot), clf
        set(gcf, 'color', [1 1 1])
        plotPoints(X,'k.',10);
        hold on
        for k=1:K
            error_ellipse(C{k}.S, C{k}.u, 0.99);
        end
        hold off
        axis equal; axis(WL);
        pause(0.1)
    end
end

return




function dist = distance_histogram(h1,h2,type)
% Histogram Distance
% 
% This function computes the distance between 2 histograms using one of the
% following methods:
%   (1) Euclidean Distance
%   (2) Histogram Intersection
%   (3) Kullback Leibler Distance
%   (4) Correlation


if nargin<3
    type = 'intersect';   % histogram intersection (default)
    if nargin<2
        error('Bad Parameters!');
    end
end

if  strcmp('euclidean',type)        % Histogram Euclidean Distance
    % normalize histograms to sum to 1
	h1 = h1/sum(sum(sum(h1)));  h2 = h2/sum(sum(sum(h2)));
    dist = sum(sum(sum((h1-h2).^2)));
elseif strcmp('intersect',type)     % Histogram Intersection
    % 1 == similar, 0 == dissimilar
    % normalize histograms to sum to 1
	h1 = h1/sum(sum(sum(h1)));  h2 = h2/sum(sum(sum(h2)));
    dist = sum(sum(sum(min(h1,h2))))/min(sum(sum(sum(h1))),sum(sum(sum(h2))));
elseif  strcmp('KL',type)           % Kullback Leibler distance (not symmetrical)
    eps = 1e-9;     % to avoid divion by zero
    h1(find(h1==0)) = eps;
    h2(find(h2==0)) = eps;
    % 0 == similar, >>> == dissimilar
    dist = sum(sum(sum(h1.*log(h1./h2))));
elseif  strcmp('correlation',type)	% Correlation Method
    h1_ = h1-mean(h1);  h2_ = h2-mean(h2);
    dist = sum(h1_.*h2_)./sqrt(sum(h1_.^2).*sum(h2_.^2));
end
return

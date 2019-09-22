function out = complex_divide(a,b,type)
% Inputs:
%   <a>     (NX3) [x/M      y/theta     0/1]
%   <b>     (NX3) [x/M      y/theta     0/1]
%   <type>  (1X1) either 0='cart' or 1='pol'

if nargin<3
    type = 0;  % cartesian coordinate
    if nargin<2
        error('Bad Parameters!');
    end
end

[a,b,flag] = complex_test_inputs(a,b);  % to avoid any worng inputs

% convert all <a> and all <b> to polar coordinate system
ind_a = find(a(:,3)==0);           ind_b = find(b(:,3)==0);
[a(ind_a,2),a(ind_a,1)] = cart2pol(a(ind_a,1),a(ind_a,2));
[b(ind_b,2),b(ind_b,1)] = cart2pol(b(ind_b,1),b(ind_b,2));

% multiply <a> by <b>
out(:,1) = a(:,1) ./ b(:,1);
out(:,2) = a(:,2) - b(:,2);

if type==0
    [out(:,1),out(:,2)] = pol2cart(out(:,2),out(:,1));
    out = [out zeros(size(a,1),1)];
else
    out = [out ones(size(a,1),1)];
end

if flag
    out = out';
end
return
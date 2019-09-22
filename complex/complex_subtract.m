function out = complex_subtract(a,b,type)
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

% convert all <a> and all <b> to cartesian coordinate system
ind_a = find(a(:,3));           ind_b = find(b(:,3));
[a(ind_a,1),a(ind_a,2)] = pol2cart(a(ind_a,2),a(ind_a,1));
[b(ind_b,1),b(ind_b,2)] = pol2cart(b(ind_b,2),b(ind_b,1));

% add <a> to <b>
out = a(:,1:2) - b(:,1:2);

if type==1
    [out(:,2),out(:,1)] = cart2pol(out(:,1),out(:,2));
    out = [out ones(size(a,1),1)];
else
    out = [out zeros(size(a,1),1)];
end

if flag
    out = out';
end
return
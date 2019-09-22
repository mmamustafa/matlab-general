function out = complex_conj(a,type)
% Inputs:
%   <a>     (NX3) [x/M      y/theta     0/1]
%   <type>  (1X1) either 0='cart' or 1='pol'

if nargin<2
    type = 0;  % cartesian coordinate
    if nargin<1
        error('Bad Parameters!');
    end
end

flag = 0;
s_a_1 = size(a,1);      s_a_2 = size(a,2);
if s_a_2~=3 && s_a_1~=3
    error('Bad Parameters! Columns or raws of <a> should equal to 3!');
end
if s_a_1==3 && s_a_2>s_a_1
    a = a';
    flag = 1;   % transpose is taken
end

% convert all <a> and all <b> to cartesian coordinate system
ind_a = find(a(:,3));
[a(ind_a,1),a(ind_a,2)] = pol2cart(a(ind_a,2),a(ind_a,1));

% change only <y> to negative
out = [a(:,1), -a(:,2)];

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
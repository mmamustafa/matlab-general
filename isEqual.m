function out = isEqual(x,y,epsilon)
% This is a vectorized Function
% size(x) must equal size(y)
%
% Updated in:  2012-08-01
% Mohamed Mustafa - UoM

if nargin<3
    epsilon = 1e-12;	% change this as needed
end

temp = x-y;
out = abs(temp)<epsilon;
out(isnan(temp)) = 1;     % Exception for infinity equality (inf-inf)
return



% Not vectorized version
% ======================
% function out = isEqual(x,y,epsilon)
% if nargin<3
%     epsilon = 1e-12;    % change this as needed
% end
% if isfinite(x) && isfinite(y)
%     out = abs(x-y)<epsilon;
% else
%     out = x==y;
% end
% return




% old implementation
% ==================
% if(abs(x-y)<epsilon)
%     out = 1;
% else
%     out = 0;
% end
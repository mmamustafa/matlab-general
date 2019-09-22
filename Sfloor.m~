% Special Floor
% This function rounds to the nearest resolution towards -ve infinity

% Inputs:
% --> x:    the number/vector/matrix
% --> res:  resolution
function y = Sfloor(x,res)
if(res==0)
	error('Resolution should not equal to zero');
else
    t1 = x./res;
    y = floor(t1 + eps(t1)).*res;
%     % Old Implementation (Doesn't work properly)
%     t1 = x./res;
%     % The following 3 lines are due to MATLAB percision problem
%     t2 = round(t1);
%     ind = find(abs(t2-t1)<1e-12);
%     t1(ind) = t2(ind);
%     % The output
%     y = floor(t1).*res;
end
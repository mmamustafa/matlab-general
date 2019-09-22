% Special round
% This function rounds to the nearest resolution

% Inputs:
% --> x:    the number/vector/matrix
% --> res:  resolution
function y = Sround(x,res)
if(res==0)
	error('Resolution should not equal to zero');
else
    y = round(x./res).*res;
end
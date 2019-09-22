function eul = dcm2eul(dcm)
% -------------------------------------------------------------------------
% Direction Cosine Matrix to Euler Angles
% 
% Usage:
%       eul = dcm2eul(dcm)
%
% Input:
%       <dcm>       (3X3) matrix
%
% Output:
%       <eul>       (3X1) vector (yaw, pitch, roll)
%
% Source:
%                   http://www.mathworks.com/access/helpdesk_r13/help/toolbox/aeroblks/directioncosinematrixtoeulerangles.html#771124
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, October 2009
% -------------------------------------------------------------------------

dim = size(dcm,2);
if dim==2
    eul = atan2(dcm(1,2),dcm(2,2));
elseif dim==3
    %eul = [atan(dcm(1,2)/dcm(1,1)), asin(-dcm(1,3)), atan(dcm(2,3)/dcm(3,3))];
    eul = [atan2(dcm(1,2),dcm(1,1)), asin(-dcm(1,3)), atan2(dcm(2,3),dcm(3,3))];
end
return
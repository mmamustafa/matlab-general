% angleMod (not working well with arrays... replace while-loop with mod and floor
% function???
% NEW FUNCTION>>> reduce_angle_fullCircle
% ##############################################
% -----------------------------------------------------------------------
%   angleMod(phi) reduce the input angle to [-pi:pi]
%
% -----------------------------------------------------------------------
function phi = angleMod(phi)
phi = rem(phi,2.0*pi);
while(abs(phi)>pi)
    phi = rem(phi,2.0*pi) - sign(phi)*2.0*pi;
end
function out = rot3DRig(in)
% 3D Right-handed Rotation Matrix around:
% x-axis, y-axis, and z-axis
%
% Usage:
%   out = rot3DRig(in)
%
% Input:
%	in(1) = a:      right-handed about z-axis (Yaw)
%	in(2) = b:      right-handed about y-axis (Pitch)
%	in(3) = c:      right-handed about x-axis (Roll)

% define each input as angle
a = in(1);  b = in(2);  c = in(3);

% right-handed rotation around each
R_x = [1 0 0;0 cos(c) sin(c);0 -sin(c) cos(c)];
R_y = [cos(b) 0 -sin(b);0 1 0;sin(b) 0 cos(b)];
R_z = [cos(a) sin(a) 0;-sin(a) cos(a) 0;0 0 1];

% Around: first z, then y, then x
out = R_x*R_y*R_z;
return

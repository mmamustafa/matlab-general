function dcm = q2dcm(q)
% -------------------------------------------------------------------------
% Quaternion to Direction Cosine Matrix
% Rotation around: Z-axis, then Y-axis, then X-axis.
% All angles are counterclockwise.
% 
% Usage:
%       dcm = q2dcm(q)
%
% Input:
%       <q>         (4X1) vector
%
% Output:
%       <dcm>       (3X3) matrix
%
% Source:           eggert_rigid_body_transformations.pdf
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, February 2010
% -------------------------------------------------------------------------
q = unit_vector(q);
dcm   = [ q(1)^2+q(2)^2-q(3)^2-q(4)^2,    2*(q(2)*q(3)-q(1)*q(4)),        2*(q(2)*q(4)+q(1)*q(3));
        2*(q(3)*q(2)+q(1)*q(4)),        q(1)^2-q(2)^2+q(3)^2-q(4)^2,    2*(q(3)*q(4)-q(1)*q(2));
        2*(q(4)*q(2)-q(1)*q(3)),        2*(q(4)*q(3)+q(1)*q(2)),        q(1)^2-q(2)^2-q(3)^2+q(4)^2];
return
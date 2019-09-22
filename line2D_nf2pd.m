function line_pd = line2D_nf2pd(line_nf)
% Line in 2D function:
% Normal Form (polar) --> Position/Direction
% 
% Inputs:
%       <line_nf>   (2XM) Normal(polar) form [r;alpha]
%
% Output:
%       <line_pd>   (4XM) Position direction format (r0 + t*v0)

r = line_nf(1,:);       % lengths of perpendicular
alpha = line_nf(2,:);   % angle with the positive x-axis

s1 = sin(alpha);    c1 = cos(alpha);

p = [r.*c1; r.*s1];     % position vector
v = [-r.*s1; r.*c1];    % direction vector

line_pd = [p;v];
return
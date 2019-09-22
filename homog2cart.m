function P = homog2cart(P)
% -------------------------------------------------------------------------
% Cartesian-to-homogeneous coordinate function.
%
% Usage:
%       P = homog2cart(P)
%
% Inputs:
%       <P>         (3XM) or (4XM) homogeneous points
%
% Outputs:
%       <P>         (2XM) or (3XM) caresian points
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, July 2010
% -------------------------------------------------------------------------
D = size(P,1);                  % dimension of the points
w = repmat(P(end,:),D-1,1);     % last element of each point in homogeneous
P = P(1:D-1,:)./w;
return
% -------------------------------------------------------------------------
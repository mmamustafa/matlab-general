function P = cart2homog(P)
% -------------------------------------------------------------------------
% Cartesian-to-homogeneous coordinate function.
%
% Usage:
%       P = cart2homog(P)
%
% Inputs:
%       <P>         (2XM) or (3XM) cartesian points
%
% Outputs:
%       <P>         (3XM) or (4XM) homogeneous points
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, July 2010
% -------------------------------------------------------------------------

P = [P;ones(1,size(P,2))];
return
% -------------------------------------------------------------------------
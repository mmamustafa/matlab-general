function [out] = unit_vector(v)
% -------------------------------------------------------------------------
% Unit Vector function.
%
% Usage:
%       [out] = unit_vector(v)
%
% Input:
%       <v>         (2XM) or (3XN) or (KXM) vectors in columns
%
% Output:
%       <out>       normalized vectors
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, November 2009
% -------------------------------------------------------------------------

out = v./repmat(sqrt(sum(v.^2)),size(v,1),1);
return
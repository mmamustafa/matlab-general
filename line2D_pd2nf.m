function line_nf = line2D_pd2nf(line_pd)
% Line in 2D function:
% Position/Direction Form --> Normal Form (polar)
% 
% Inputs:
%       <line_pd>   (4XM) Line parameters in position/direction form [P0 + t*D0]
%
% Output:
%       <line_nf>   (2XM) Line parameters in normal/polar Form [r;alpha]

M = size(line_pd,2);        % number of lines
if M>0
    [r,t] = distance_point_line(zeros(2,M),line_pd);        % find <r>
    IP = line_pd(1:2,:) + repmat(t,2,1).*line_pd(3:4,:);    % Intersection Point to evaluate <alpha>
    alpha = atan2(IP(2,:),IP(1,:));                         % find <alpha>
    line_nf = [r;alpha];
else
    line_nf = [];
end
return
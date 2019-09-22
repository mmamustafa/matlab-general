function [dist,t1,t2,info] = distance_line_line(L1,L2)
% -------------------------------------------------------------------------
% Distance between 2 lines in 3D space
% Usage:
%       [dist,t1,t2,info] = distance_line_line(L1,L2)
%
% Inputs:
%       <L1>        (6XM) First set of lines with following format: r1 + t*v1
%       <L2>        (6XM) Second set of lines with following format: r2 + t*v2
%
% Outputs:
%       <dist>      (1XM) distance between corresponding lines
%       <t1>        (1XM) parameters of points on L1 that satisfy the shortest distance
%       <t2>        (1XM) parameters of points on L2 that satisfy the shortest distance
%       <info>      (1XM) -->   0:  Lines are skewed or intersect
%                               1:  Lines are parallel or on each other
% 
% Source:           http://www.coventry.ac.uk/ec//jtm/slides/8/sld8p5.pdf
%                   http://www.mc.edu/campus/users/travis/maa/proceedings/spring2001/bard.himel.pdf
%                   https://math.stackexchange.com/questions/1993953/closest-points-between-two-lines
%
% Implementation:   Mohamed Mustafa
%                   Carnegie Mellon Qatar, September 2009
% -------------------------------------------------------------------------
if nargin<2
    error('Bad Parameters!');
end
if size(L1,1)~=size(L2,1) || size(L1,2)~=size(L2,2)
    error('L1 & L2 should have the same size! (6XM Matrix).');
end
if size(L1,1)<6
    error('L1 & L2 should have size of 6XM !');
end

% epsilon is very small number
eps = 1e-3;

d_r = L1(1:3,:) - L2(1:3,:);
v_cross = cross(L1(4:6,:),L2(4:6,:));
dr_v_dot = dot(d_r,v_cross);
dr_v_dot(find(dr_v_dot<eps)) = 0;   % if dot product is very small --> force to be zero
dist = abs(dr_v_dot./sqrt(sum(v_cross.^2)));

% fix NaN values in dist: either parallel lines or same line
ind1 = find(isnan(dist));
if length(ind1)>0
    % find distance between parallel lines using source above
    d_r_2 = d_r(:,ind1);
    a = L1(4:6,ind1);
    dist(ind1) = sqrt(dot(d_r_2,d_r_2)-((dot(d_r_2,a)).^2)./(sum(a.^2)));
end

if nargout>1
    % Find t & s where shortest distance is found
    % Points are found by solving 2 equations:  v1 dot (L1-L2) == 0
    %                                           v2 dot (L1-L2) == 0
    r1 = L1(1:3,:); v1 = L1(4:6,:);
    r2 = L2(1:3,:); v2 = L2(4:6,:);
    
    a = sum(v1.^2); b = -dot(v1,v2); c = b; d = sum(v2.^2);
    e = dot(v1,r2-r1); f = dot(v2,r1-r2);
    
    t2 = (c.*e-a.*f)./(c.*b-a.*d);
    t2(find(isnan(t2))) = 0;   % fix the NaN entries
    t2(find(isinf(t2))) = 0;   % fix the Inf entries
    t1 = (e-b.*t2)./a;

    if nargout>3
        info = zeros(1,size(L1,2));
        info(ind1) = 1;
    end
end
return
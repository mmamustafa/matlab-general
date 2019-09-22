% square
% -----------------------------------------------------------------------
%   square(x0,y0,s,theta) plots squares with the following
%   parameters:
%   x0 = row vector of x values (right)
%   y0 = row vwctor of y values (bottom)
%   s  = row vector of side length
%   theta = vector of rotation angle with respect to +ve x-axis
%   c_p = color/pointer.  e.g. 'b.' == blue with dots,
%                              'r*' == red with stars
%         Default is Red with dots.
% -----------------------------------------------------------------------

function pts = square(x0,y0,s,theta,c_p)
if nargin<4
    theta = 0;
    c_p = 'r.';
elseif nargin<5
    c_p = 'r.';
end

if(length(x0)~=0)
    nop = 10;
    inc_s = s/nop;
    s = abs(s);

    cosine = cos(theta);
    sine = sin(theta);
    
    % here the starting point (lower-left) and the center points of the square
    x = [x0 x0+(s/2).*cosine-(s/2).*sine];
    y = [y0 y0+(s/2).*sine+(s/2).*cosine];

    for i=1:nop
        % each of the following have to be separate because theta is a matrix
        p1x = x0 + (inc_s*i).*cosine;
        p1y = y0 + (inc_s*i).*sine;

        p2x = x0 + (inc_s*i).*cosine - (s).*sine;
        p2y = y0 + (inc_s*i).*sine + (s).*cosine;

        p3x = x0 -(inc_s*i).*sine;
        p3y = y0 + (inc_s*i).*cosine;

        p4x = x0 + s.*cosine - (inc_s*i).*sine;
        p4y = y0 + s.*sine + (inc_s*i).*cosine;

        x = [x p1x p2x p3x p4x];
        y = [y p1y p2y p3y p4y];
    end
    if nargout>0
        pts = [x;y];
        %pts(:,end) = []; % delete the repeated last point (which is the same as last-2)
        pts(:,2) = [];  % delete the second element (center point in the square)
    end
    plot(x,y,c_p);
end
return
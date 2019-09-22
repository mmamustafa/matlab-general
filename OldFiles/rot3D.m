% 3D Rotation Matrix around either:
% x-axis, y-axis, or z-axis
function y = rot3D(theta,axis)
if axis=='x'
    y = [1 0 0;0 cos(theta) sin(theta);0 -sin(theta) cos(theta)];
else if axis=='y'
        y = [cos(theta) 0 -sin(theta);0 1 0;sin(theta) 0 cos(theta)];
    else if axis=='z'
            y = [cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0;0 0 1];
        end
    end
end
% this function return either 0 or 1 for checking whether
% the target angle is between angle_1 and angle_2
% all input angles are with respect to +ve x-axis in global frame
function y = isAngleBetween(theta_t,theta_1,theta_2)
% transform everything to new frame where P1 is the +ve x-axis
theta_2 = angleMod(theta_2 - theta_1);
theta_t = angleMod(theta_t - theta_1);

% may be we need exception later to handle if P1 and theta_t are aligned
% e.g. theta_1 = theta_t = 0
if(sign(theta_t)==sign(theta_2) && abs(theta_t)<=abs(theta_2))
    % target angle is between P1 and P2
    y = 1;
else
    % target angle is NOT between P1 and P2
    y = 0;
end
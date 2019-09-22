% this function returns the radius of the circle given position and angle
% of two point in the plane
function R = calcRadius(x_r,y_r,theta_r,x,y,theta)
phi = theta-theta_r
D = calcDist(x-x_r,y-y_r)
R = sign(phi)*sqrt(D/(2*(1-cos(angleMod(phi)))));
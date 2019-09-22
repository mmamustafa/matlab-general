% Use <estimate_line> instead
% #############################3
% function to transform from points to line with m & b
% object in JAVA
function [m b] = P2L(x_1,y_1,x_2,y_2)

if(x_1==x_2)
    m = [];
    b = [];
else
    m = (y_1 - y_2)/(x_1 - x_2);
    b = y_1 - m*x_1;
end
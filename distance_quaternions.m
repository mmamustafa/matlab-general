function d = distance_quaternions(q1,q2)
d = 1-abs(dot(q1,q2));
return
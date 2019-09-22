function ellipse(x_c, v1, v2, v3)
% put the exceptions and if-statements

a = sqrt(sum(v1.^2)); b = sqrt(sum(v2.^2));  c =1;
x1 = [-a:0.01:a]; y1 = sqrt(1-(x1.^2)./(a.^2));
x = [x1 fliplr(x1)]; y = [y1 fliplr(-y1)];

X1 = [[a 0 0]',[0 b 0]',[0 0 c]'];
X2 = [v1 v2 v3];
R = getRotationPointsQuaternion(X1,X2);

R = R(1:2,1:2);

temp = R*[x;y];
plot(temp(1,:),temp(2,:))
return
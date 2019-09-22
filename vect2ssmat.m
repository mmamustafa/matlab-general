function mat = vect2ssmat(vect)
% vector to skew-symmetric matric function
% <vect> should have 3 rows only
% if <vect> is a 3Xn matrix, <mat> will return 3x3n matrix (augmented)

n = size(vect,2);   % number of vectors
temp = [ zeros(1,n);
         vect(3,:);
        -vect(2:3,:);
         zeros(1,n);
         vect(1:2,:);
        -vect(1,:);
         zeros(1,n)];   % this is the skewed-symmetric matrix reshaped as on column

mat = reshape(temp,3,[]);
return
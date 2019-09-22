function C = Iunion(A,B)
% Interval Union Function (similar to C++ in QT)
if(B(1)==-999 && B(2)==-999 && A(1)==-999 & A(2)==-999)
    C = [-999,-999];
elseif(B(1)==-999 && B(2)==-999)
    C = A;
elseif(A(1)==-999 && A(2)==-999)
    C = B;
else
    C = [min(A(1),B(1)) max(A(2),B(2))];
end
return
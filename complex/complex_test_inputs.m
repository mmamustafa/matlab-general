function [a,b,flag] = complex_test_inputs(a,b)
flag = 0;
s_a_1 = size(a,1);      s_a_2 = size(a,2);
s_b_1 = size(b,1);      s_b_2 = size(b,2);

if s_a_1~=s_b_1 || s_a_2~=s_b_2
    error('Size <a> does not equal to size <b>!')
end
if s_a_2~=3 && s_a_1~=3
    error('Bad Parameters! Columns or raws of <a> should equal to 3!');
end
if s_a_1==3 && s_a_2>s_a_1
    a = a';     b = b';
    flag = 1;   % transpose is taken
end
return
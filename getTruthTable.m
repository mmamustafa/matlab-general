function TT = getTruthTable(N)
% Create truth table where N is the number of variables
TT = rem(floor((0:2^N-1).'*pow2(1-N:0)),2) ;
return
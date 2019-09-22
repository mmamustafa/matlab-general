function [Code,DV] = ADC(OV,nb,range)
% Analog-to-Digital Converter(s)
%
% Inputs: (Usually N = 1)
%   <OV>        (M x N x 1) Original values
%   <nb>        (1 x 1 x 1) number of bits
%   <range>     (2 x N x 1) max and min of each ADC
%
% Outputs:
%   <Code>      (M x N x 1) Quantized values
%   <DV>        (M x N x nb) Digital values
%

q = (range(2,:)-range(1,:))/(2^nb)
Code = floor((OV - repmat(range(1,:),size(OV,1),1))./repmat(q,size(OV,1),1));

return
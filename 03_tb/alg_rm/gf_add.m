function [sum] = gf_add(m,a,b)
%[sum] = gf_add(m,a,b)
% m   , bit width of symbols;
% a   , adder input1 ,decimal format
% b   , adder input2 ,decimal format
% sum , adder output ,decimal format

a_bin = de2bi(a,m);
b_bin = de2bi(b,m);
sum_bin = xor(a_bin,b_bin);
sum = bi2de(sum_bin);

end

% clc
% clear all
% for i=1:10
% a = randi(7,1,1);
% b = randi(7,1,1);

% sum = gf_add(3,a,b);
% sum_gf = gf(a,3)+gf(b,3);
% sum_ref = double(sum_gf.x);
% diff = sum - sum_ref
% sum
% end
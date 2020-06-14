function [prod] = gf_mult(m,a,b)
%[prod] = gf_mult(m,a,b)
% m   , bit width of symbols;
% a   , multiplier input1 ,decimal format
% b   , multiplier input2 ,decimal format
% prod, multiplier output ,decimal format

ele_bin =  gftuple([-1:2^m-2]',m,2);

 
%table 1, power to decimal
ele_dec =  bi2de(ele_bin);

%%table 2, decimal to power
for i = 1:length(ele_dec)
    if(ele_dec(i) ~= 0)
        idx_table(ele_dec(i)) =  i-2;
    else
        idx_table(length(ele_dec)) =  i-2;
    end
end


if a == 0 || b == 0
    prod = 0;
else
   a_pow =  idx_table(a);
   b_pow =  idx_table(b);   
   ab_pow = mod((a_pow+b_pow),2^m-1);
   prod   = ele_dec(ab_pow+2);
end

% ele_dec'
% idx_table
% a_pow
% b_pow
% prod

end
%{
 clc
 clear all
 for i=1:30
 a = randi(7,1,1);
 b = randi(7,1,1);

 prod = gf_mult(3,a,b);
 prod_gf = gf(a,3).*gf(b,3);
 prod_ref = double(prod_gf.x);
 diff = prod - prod_ref
 
 end
%}


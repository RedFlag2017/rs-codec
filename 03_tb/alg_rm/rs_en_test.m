clc
clear all
close all
delete('.\data_save\*');

% blk_n = 2;
print_on = 0;

rand('state',0);

% blk_n = 2;
% m = 8;
% r = 16;

% n_s = 2^m -1 - 51;





rs_enc_cfg;
n   = 2^m -1;
is_shorten_code = (n_s < n );

k  = n   - r;
k_s= n_s - r;


save_bw = [4 4 4 4 8 8 8 8];
% filename = '../rs_enc_cfg.svh';
% h=fopen(filename,'w');
% fprintf(h,['`define SYM_BW    ', num2str(m),'\n']);
% fprintf(h,['`define R_NUM     ', num2str(r),'\n']);
% fprintf(h,['`define BLK_NUM     ', num2str(blk_n),'\n']);
% fclose(h);



prim_poly = primpoly(m);
alpha = gf(2, m, prim_poly);  

g_x = rsgenpoly(n,k);
g = double(g_x.x);
g0_gr = fliplr(g);



disp(['m =' num2str(m) ,'  n_s =' num2str(n_s) ,'  k_s =' num2str(k_s) ,'  r =' num2str(r) ]);

if is_shorten_code
    disp('==============Is Shorten Code================')
end    

for blk_idx = 1:blk_n
    disp(['blk_idx = ' num2str(blk_idx) ',  total blk_cnt= ' num2str(blk_n)]);

    data_k_s =randi([0 (2^m -1) ],1,k_s);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %golden result
    data_k = [zeros(1,n-n_s),data_k_s];
    data_in_k = data_k;
    msg = gf(data_in_k,m);
    rs_en_data = rsenc(msg,n,k,g_x) ;
    rs_en_data2 = double(rs_en_data.x);
    rs_en_data2 = rs_en_data2(n-n_s+1:end);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% LFSR implement
    [data_out] = rs_lfsr(m,n_s,k_s,g0_gr,data_k_s,print_on);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    %%Show Result
    disp('------------------------------------------------------------------------------------------------------------------------------------');
    disp(['Input of RS encoder                     :  ' num2str(data_k_s)]);
    disp(['Output of Matlab built-in function rsenc:  ' num2str(rs_en_data2)]);
    disp(['Output of Matlab LFSR based RS Encoder  :  ' num2str(data_out)]);
    disp(['Generation polynomial                   :  ' num2str(g0_gr) ])

    diff = rs_en_data2 - data_out;
    diff_nonzero = find(diff);
    if isempty(diff_nonzero)
        disp('The output of the two implement method is the same.:)');
    else
        disp('!!!!!!!!Error Happend!');
    end
    disp('---------------------------------------------------END------------------------------------------------------------------------------');

    savedata('.\data_save\data_encoder_in.txt',data_k_s,save_bw(m));
    savedata('.\data_save\data_encoder_out.txt',data_out,save_bw(m));

end
exit


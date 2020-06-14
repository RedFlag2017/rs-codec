clc
clear all
delete('.\data_save\*');
rand('state',0);
rs_dec_cfg;

print_on = 0;


n   = 2^m -1;
is_shorten_code = (n_s < n );

k  = n   - r;
k_s= n_s - r;


save_bw = [4 4 4 4 8 8 8 8];


prim_poly = primpoly(m);

for blk_idx = 1:blk_n
    data_k_s=randi([0 (2^m -1) ],1,k_s);

    data_k_s=reshape(data_k_s',1,[]);
    g_x = rsgenpoly(n,k);


    data_k = [zeros(1,n-n_s),data_k_s];
    data_in_k = data_k;
    msg = gf(data_in_k,m);
    rs_en_data = rsenc(msg,n,k,g_x) ;
    rs_en_data2 = double(rs_en_data.x);

    rs_en_data2 = rs_en_data2(n-n_s+1:end);


    % disp(['the original data is          : ', num2str(data_k_s)]);
    % disp(['the original code is          : ', num2str(rs_en_data2)]);

    %%  引入错误
    max_gf_elm = 2^m - 1;
    max_err_num = floor(r/2);
    err_num = randi([1 max_err_num],1,1);
    % err_num = 8;
    data_enc = rs_en_data2;

    [data_with_err,msg_zeros]  = err_add( data_enc, m,n_s, max_gf_elm, err_num );

    %
    % err_msg = zeros(1,n);
    % err_msg(1:8) = [10 20 30 40 50 60 70 80];
    % data_with_err = bi2de(xor(de2bi(data_enc,m),de2bi(err_msg,m)));
    % data_with_err = data_with_err';




    data_with_err_gf = gf(data_with_err,m);
    msg = data_with_err;
    % disp(['the received code is          : ', num2str(data_with_err)]);
    % disp(['err_num                       : ', num2str(err_num)]);

    msg_n = [zeros(1,n-n_s),msg];

    %%伴随式计�?
    [S] = syndrome(msg,n_s,k_s,m);
    % [S_n] = syndrome(msg_n,n,k,m);
    % disp(['syndrome calculation          : ' num2str(S')]);  
    % disp(['syndrome calculation(n=2^m-1) : ' num2str(S_n')]);  


    %%关键方程求解
    [lamda,omega] = kes(m,n_s,k_s,S);
    % [lamda_n,omega_n] = kes(m,n,k,S);
    % disp(['KES calculation,lamda         : ' num2str(double(lamda.x))]);
    % disp(['KES calculation,omega         : ' num2str(double(omega.x))]);

    % disp(['KES calculation,lamda(n=2^m-1): ' num2str(double(lamda_n.x))]);
    % disp(['KES calculation,omega(n=2^m-1): ' num2str(double(omega_n.x))]);

    %%错位位置计算
    [error] = err_locate(m,n_s,k_s,prim_poly,lamda);
    % [error_n] = err_locate(m,n,k,prim_poly,lamda_n);
    %%错位值计�?
    [error_out] = err_value(m,n_s,k_s,prim_poly,lamda,omega,error);
    % [error_out_n] = err_value(m,n,k,prim_poly,lamda_n,omega_n,error_n);
    %%误码矫正



    % disp(['Error Location                : ' num2str(error(1,:))]);
    % disp(['Error Value                   : ' num2str(error_out(2,:))]);  
    % disp(['Error Location(n=2^m-1)       : ' num2str(error_n(1,:))]);
    % disp(['Error Value(n=2^m-1)          : ' num2str(error_out_n(2,:))]);  



    found = find(error_out(1,:)~=0);
    reccode_gf = data_with_err_gf;
    reccode_gf(found) = data_with_err_gf(found) - gf(error_out(2,found),m);




    disp(['------------------------------------------------blk_idx = ' num2str(blk_idx) '------------------------------------------------------------------------------------']);
    disp(['m =' num2str(m) ,'  n_s =' num2str(n_s) ,'  k_s =' num2str(k_s) ,'  r =' num2str(r) ]);

    if is_shorten_code
        disp('==============Is Shorten Code================')
        disp(['Shorten Length          : ' num2str(n - n_s)]);  
    end   



    disp(['the original data is         : ', num2str(data_k_s)]);
    disp(['the original code is         : ', num2str(rs_en_data2)]);
    disp(['the received code is         : ', num2str(data_with_err)]);
    disp(['the corrected code is        : ', num2str(double(reccode_gf.x))]);

    disp(['found error(s) at location(s): ',num2str(found)]);
    disp(['calulated error magnitudes   : ', num2str(error_out(2,found))]);

    diff = double(reccode_gf.x)  - rs_en_data2;
    diff_nonzero = find(diff);
    if isempty(diff_nonzero)
        disp('The output of RS Decoder  is the same with the Origin Code!');
    else
        disp('!!!!!!!!Error Happend!');
    end

    disp('-----------------------------------------------END----------------------------------------------------------------------------------');

    if print_on == 1
        disp('------------------------------------------------------------------------------------------------------------------------------------');
        disp(['Intermediate computation process         : ']);    
        disp(['syndrome calculation         : ' num2str(S')]);    
        disp(['KES calculation,lamda        : ' num2str(double(lamda.x))]);
        disp(['KES calculation,omega        : ' num2str(double(omega.x))]);
        disp(['Error Location               : ' num2str(error(1,:))]);
        disp(['Error Value                  : ' num2str(error_out(2,:))]);    
        disp('-----------------------------------------------END----------------------------------------------------------------------------------');
    end
    
    savedata('.\data_save\data_decoder_out.txt',rs_en_data2,save_bw(m));
    savedata('.\data_save\data_with_err.txt',data_with_err,save_bw(m));
end
  exit






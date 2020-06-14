function [data_with_err,msg_zeros] = err_add( data,m ,n, max_gf_elm, err_num )

    % err_num = randint(1,1,[1 max_err_num]);
    


    err_pos = zeros(1,err_num);
    err_pos = randperm(n,err_num);

    err_val = randi([1 max_gf_elm],1,err_num);

    msg_zeros =  zeros(1,n);
    
    for idx = 1:err_num
        msg_zeros(err_pos(idx)) = err_val(idx);
    end
    
    msg_zeros_gf = gf(msg_zeros,m);

    data_gf = gf(data,m);

    data_with_err = msg_zeros_gf + data_gf;
    
    data_with_err = double(data_with_err.x);

end
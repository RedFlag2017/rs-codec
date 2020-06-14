function []=savedata(filename,data,bitwidth)
    hexwidth=num2str(bitwidth/4);
    h=fopen(filename,'a');
    if(isreal(data))
        for i=1:length(data)
            fprintf(h,['%0',hexwidth,'x\n'],mod(data(i),2^bitwidth));
        end
    else
        for i=1:length(data)
            fprintf(h,['%0',hexwidth,'x','%0',hexwidth,'x\n'],mod(real(data(i)),2^bitwidth),mod(imag(data(i)),2^bitwidth));
        end
    end
    fclose(h);
end

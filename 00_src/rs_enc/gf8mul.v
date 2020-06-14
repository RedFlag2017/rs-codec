`timescale 1ns/100ps
module gf8mul(
    input       [2:0] a,
    input       [2:0] b,
    output  reg [2:0] z
);
always @(*)
begin
    case (b)
        3'd1:
            begin
                z[0] = a[0];
                z[1] = a[1];
                z[2] = a[2];
            end
        3'd2:
            begin
                z[0] = a[2];
                z[1] = a[0] ^ a[2];
                z[2] = a[1];
            end
        3'd3:
            begin
                z[0] = a[0] ^ a[2];
                z[1] = a[0] ^ a[1] ^ a[2];
                z[2] = a[1] ^ a[2];
            end
        3'd4:
            begin
                z[0] = a[1];
                z[1] = a[1] ^ a[2];
                z[2] = a[0] ^ a[2];
            end
        3'd5:
            begin
                z[0] = a[0] ^ a[1];
                z[1] = a[2];
                z[2] = a[0];
            end
        3'd6:
            begin
                z[0] = a[1] ^ a[2];
                z[1] = a[0] ^ a[1];
                z[2] = a[0] ^ a[1] ^ a[2];
            end
        3'd7:
            begin
                z[0] = a[0] ^ a[1] ^ a[2];
                z[1] = a[0];
                z[2] = a[0] ^ a[1];
            end
        default:
            begin
                z[0] = 0; 
                z[1] = 0; 
                z[2] = 0; 
            end
    endcase
end
endmodule

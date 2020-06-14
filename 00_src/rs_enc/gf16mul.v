`timescale 1ns/100ps
module gf16mul(
    input       [3:0] a,
    input       [3:0] b,
    output  reg [3:0] z
);
always @(*)
begin
    case (b)
        4'd1:
            begin
                z[0] = a[0];
                z[1] = a[1];
                z[2] = a[2];
                z[3] = a[3];
            end
        4'd3:
            begin
                z[0] = a[0] ^ a[3];
                z[1] = a[0] ^ a[1] ^ a[3];
                z[2] = a[1] ^ a[2];
                z[3] = a[2] ^ a[3];
            end
        4'd4:
            begin
                z[0] = a[2];
                z[1] = a[2] ^ a[3];
                z[2] = a[0] ^ a[3];
                z[3] = a[1];
            end
        4'd6:
            begin
                z[0] = a[2] ^ a[3];
                z[1] = a[0] ^ a[2];
                z[2] = a[0] ^ a[1] ^ a[3];
                z[3] = a[1] ^ a[2];
            end
        4'd7:
            begin
                z[0] = a[0] ^ a[2] ^ a[3];
                z[1] = a[0] ^ a[1] ^ a[2];
                z[2] = a[0] ^ a[1] ^ a[2] ^ a[3];
                z[3] = a[1] ^ a[2] ^ a[3];
            end
        4'd8:
            begin
                z[0] = a[1];
                z[1] = a[1] ^ a[2];
                z[2] = a[2] ^ a[3];
                z[3] = a[0] ^ a[3];
            end
        4'd9:
            begin
                z[0] = a[0] ^ a[1];
                z[1] = a[2];
                z[2] = a[3];
                z[3] = a[0];
            end
        4'd12:
            begin
                z[0] = a[1] ^ a[2];
                z[1] = a[1] ^ a[3];
                z[2] = a[0] ^ a[2];
                z[3] = a[0] ^ a[1] ^ a[3];
            end
        4'd13:
            begin
                z[0] = a[0] ^ a[1] ^ a[2];
                z[1] = a[3];
                z[2] = a[0];
                z[3] = a[0] ^ a[1];
            end
        4'd14:
            begin
                z[0] = a[1] ^ a[2] ^ a[3];
                z[1] = a[0] ^ a[1];
                z[2] = a[0] ^ a[1] ^ a[2];
                z[3] = a[0] ^ a[1] ^ a[2] ^ a[3];
            end
        default:
            begin
                z[0] = 0; 
                z[1] = 0; 
                z[2] = 0; 
                z[3] = 0; 
            end
    endcase
end
endmodule

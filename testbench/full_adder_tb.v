`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 08:56:35 PM
// Design Name: 
// Module Name: full_adder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder_tb(
    );
    reg tb_A_in, tb_B_in, tb_C_in;
    wire tb_S_out, tb_C_out;
    full_adder dut(.A_in(tb_A_in), .B_in(tb_B_in), .C_in(tb_C_in), .S_out(tb_S_out), .C_out(tb_C_out));
    
    integer i, j, k;
    initial begin
        for(i=0;i<2;i=i+1)begin
            tb_A_in = i;
            for(j=0;j<2;j=j+1)begin
                tb_B_in = j;
                for(k=0;k<2;k=k+1)begin
                    tb_C_in = k;
                    #1;
                end
            end
        end
    end
endmodule

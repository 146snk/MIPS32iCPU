`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 08:44:00 PM
// Design Name: 
// Module Name: half_adder_tb
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


module half_adder_tb(
    );
    reg tb_A_in, tb_B_in;
    wire tb_S_out, tb_C_out;	
    half_adder dut(.A_in(tb_A_in), .B_in(tb_B_in), .S_out(tb_S_out), .C_out(tb_C_out));
    
	initial begin
        tb_A_in = 0; tb_B_in = 0;
        #1
        tb_B_in = 1;
        #1
        tb_A_in = 1;
        #1
        tb_B_in = 0;
    end

endmodule

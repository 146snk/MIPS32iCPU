`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:22:21 PM
// Design Name: 
// Module Name: bit8_look_ahead_carry_addder_tb
// Project Name: RV32i-CPU
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


module bit8_look_ahead_carry_addder_tb(
    );
	reg [7:0] tb_A_in;
    reg [7:0] tb_B_in;
    reg tb_C_in;
    wire [7:0] tb_S_out;
    wire tb_C_out;
    wire [7:0] tb_AND_out;
    wire [7:0] tb_OR_out;
    wire [7:0] tb_XOR_out;
    
    bit8_look_ahead_carry_adder dut(.A_in(tb_A_in), .B_in(tb_B_in), .C_in(tb_C_in),
        .S_out(tb_S_out), .C_out(tb_C_out), .AND_out(tb_AND_out), .OR_out(tb_OR_out),
        .XOR_out(tb_XOR_out));
    
	integer i,j;
    initial begin
//		tb_C_in = 0;
//		for(i=0;i<256;i=i+1)begin
//			tb_A_in = i;
//			for(j=0;j<256;j=j+1)begin
//				tb_B_in = j; 
//			end
//		end
        tb_A_in = 8'b1001_0100; tb_B_in = 8'b0011_0101; tb_C_in = 1;
    end
endmodule

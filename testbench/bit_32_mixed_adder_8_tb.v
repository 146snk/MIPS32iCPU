`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:49:59 PM
// Design Name: 
// Module Name: bit_32_mixed_adder_8_tb
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


module bit_32_mixed_adder_8_tb(
    );
	reg [31:0] tb_A_in;
    reg [31:0] tb_B_in;
    reg tb_C_in;
    wire [31:0] tb_S_out;
    wire tb_C_out;
    wire [31:0] tb_AND_out;
    wire [31:0] tb_OR_out;
    wire [31:0] tb_XOR_out;
    
    bit_32_mixed_adder_8 dut(.A_in(tb_A_in), .B_in(tb_B_in), .C_in(tb_C_in),
        .S_out(tb_S_out), .C_out(tb_C_out), .AND_out(tb_AND_out), .OR_out(tb_OR_out),
        .XOR_out(tb_XOR_out));
    
    initial begin
        tb_A_in = 32'd4095; tb_B_in = 32'd13121; tb_C_in = 0;
    end
endmodule

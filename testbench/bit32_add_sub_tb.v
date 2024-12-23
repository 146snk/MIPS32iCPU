`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2024 12:07:19 PM
// Design Name: 
// Module Name: bit32_add_sub_tb
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


module bit32_add_sub_tb(
    );
	reg [31:0] tb_A_in;
    reg [31:0] tb_B_in;
    reg tb_ctrl_in;
    wire [31:0] tb_AND_out;
    wire [31:0] tb_OR_out;
    wire [31:0] tb_XOR_out;
    wire [31:0] tb_S_out;
    wire tb_err_out;
    
    bit32_add_sub dut(.A_in(tb_A_in), .B_in(tb_B_in), .ctrl_in(tb_ctrl_in), .AND_out(tb_AND_out), .OR_out(tb_OR_out), .XOR_out(tb_XOR_out), .S_out(tb_S_out),.err_out(tb_err_out));
    initial begin
        tb_A_in = 32'd4095; tb_B_in = 32'd13121; tb_ctrl_in = 1;
    end
endmodule

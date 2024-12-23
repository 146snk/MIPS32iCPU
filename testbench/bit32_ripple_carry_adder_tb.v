`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:27:41 PM
// Design Name: 
// Module Name: bit32_ripple_carry_adder_tb
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


module bit32_ripple_carry_adder_tb(
    );
    reg [31:0] tb_A_in;
    reg [31:0] tb_B_in;
    reg tb_C_in;
    wire [31:0] tb_S_out;
    wire tb_C_out;
    bit32_ripple_carry_adder dut(.A_in(tb_A_in), .B_in(tb_B_in), .C_in(tb_C_in), .S_out(tb_S_out), .C_out(tb_C_out));
    
    initial begin
        tb_A_in = 15; tb_B_in = 49; tb_C_in = 1;
    end
endmodule

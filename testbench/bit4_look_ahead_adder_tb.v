`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 03:46:01 PM
// Design Name: testbench for 4-bit look-ahead adder with and,or,xor output
// Module Name: bit4_look_ahead_adder_tb
// Project Name: RV32I-CPU
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


module bit4_look_ahead_adder_tb(
    );
    reg [3:0] tb_A_in;
    reg [3:0] tb_B_in;
    reg tb_C_in;
    wire [3:0] tb_S_out;
    wire tb_C_out;
    wire [3:0] tb_AND_out;
    wire [3:0] tb_OR_out;
    wire [3:0] tb_XOR_out;
    
    bit4_look_ahead_carry_adder dut(.A_in(tb_A_in), .B_in(tb_B_in), .C_in(tb_C_in),
        .S_out(tb_S_out), .C_out(tb_C_out), .AND_out(tb_AND_out), .OR_out(tb_OR_out),
        .XOR_out(tb_XOR_out));
    
    initial begin
        tb_A_in = 4'b1001; tb_B_in = 4'b0011; tb_C_in = 0;
    end
endmodule

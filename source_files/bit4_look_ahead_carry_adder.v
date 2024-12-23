`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 02:58:54 PM
// Design Name: 4-bit look-ahead adder with and,or,xor output
// Module Name: bit4_look_ahead_carry_adder
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


module bit4_look_ahead_carry_adder(
    input [3:0] A_in,
    input [3:0] B_in,
    input C_in,
    output [3:0] AND_out,
    output [3:0] OR_out,
    output [3:0] XOR_out,
    output [3:0] S_out,
    output C_out
    );
    wire [4:0] carry;
    wire [3:0] C_g;
    wire [3:0] C_p;
    assign carry[0] = C_in;
    assign C_out = carry[4];
    
	// logic operations
    assign C_g = A_in & B_in;
    assign C_p = A_in | B_in;
    assign AND_out = C_g;
    assign OR_out = C_p;
    assign XOR_out = A_in ^ B_in;
    // look ahead logic
    assign carry[1] = C_g[0] | (C_p[0] & C_in);
    assign carry[2] = C_g[1] | (C_p[1] & C_g[0]) | (C_p[1] & C_p[0] & C_in);
    assign carry[3] = C_g[2] | (C_p[2] & C_g[1]) | (C_p[2] & C_p[1] & C_g[0]) | (C_p[2] & C_p[1] & C_p[0] & C_in);
    assign carry[4] = C_g[3] | (C_p[3] & C_g[2]) | (C_p[3] & C_p[2] & C_g[1]) | (C_p[3] & C_p[2] & C_p[1] & C_g[0]) | (C_p[3] & C_p[2] & C_p[1] & C_p[0] & C_in);
	// S_out
	assign S_out = XOR_out ^ carry[3:0];
	
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:17:06 PM
// Design Name: 8-bit look ahead carry adder 
// Module Name: bit8_look_ahead_carry_adder
// Project Name: RISC32i_CPU
// Description: 8-bit full look ahead carry adder
// Dependencies: none
//////////////////////////////////////////////////////////////////////////////////


module bit8_look_ahead_carry_adder(
	input [7:0] A_in,
    input [7:0] B_in,
    input C_in,
    output [7:0] AND_out,
    output [7:0] OR_out,
    output [7:0] XOR_out,
    output [7:0] S_out,
    output C_out
    );
	wire [8:0] carry;
    wire [7:0] C_g;
    wire [7:0] C_p;
    assign carry[0] = C_in;
    assign C_out = carry[8];
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
    assign carry[4] = C_g[3] | (C_p[3] & C_g[2]) | (C_p[3] & C_p[2] & C_g[1]) | (C_p[3] & C_p[2] & C_p[1] & C_g[0]) | 
		(C_p[3] & C_p[2] & C_p[1] & C_p[0] & C_in);
	assign carry[5] = C_g[4] | (C_p[4] & C_g[3]) | (C_p[4] & C_p[3] & C_g[2]) | (C_p[4] & C_p[3] & C_p[2] & C_g[1]) | 
		(C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_g[0]) | (C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_p[0] & C_in);
	assign carry[6] = C_g[5] | (C_p[5] & C_g[4]) | (C_p[5] & C_p[4] & C_g[3]) | (C_p[5] & C_p[4] & C_p[3] & C_g[2]) | 
		(C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_g[1]) | (C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_g[0]) | 
		(C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_p[0] & C_in);
	assign carry[7] = C_g[6] | (C_p[6] & C_g[5]) | (C_p[6] & C_p[5] & C_g[4]) | (C_p[6] & C_p[5] & C_p[4] & C_g[3]) | 
		(C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_g[2]) | (C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_g[1]) | 
		(C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_g[0]) | (C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_p[0] & C_in);
	assign carry[8] = C_g[7] | (C_p[7] & C_g[6]) | (C_p[7] & C_p[6] & C_g[5]) | (C_p[7] & C_p[6] & C_p[5] & C_g[4]) | 
		(C_p[7] & C_p[6] & C_p[5] & C_p[4] & C_g[3]) | (C_p[7] & C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_g[2]) | 
		(C_p[7] & C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_g[1]) | (C_p[7] & C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_g[0]) | 
		(C_p[7] & C_p[6] & C_p[5] & C_p[4] & C_p[3] & C_p[2] & C_p[1] & C_p[0] & C_in);
	// S_out
	assign S_out = XOR_out ^ carry[7:0];
endmodule

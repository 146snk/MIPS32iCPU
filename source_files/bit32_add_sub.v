`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:17:06 PM
// Design Name: 32-bit add/sub
// Module Name: bit32_add_sub
// Project Name: RISC32i_CPU
// Description: 32-bit adder & subtractor with and/or/xor output
// Dependencies: bit_32_mixed_adder_8, bit8_look_ahead_carry_adder
//////////////////////////////////////////////////////////////////////////////////


module bit32_add_sub(
    input [31:0] A_in,
    input [31:0] B_in,
    input ctrl_in,
    output [31:0] AND_out,
    output [31:0] OR_out,
    output [31:0] XOR_out,
    output [31:0] S_out,
    output err_out
    );
    // add/sub input
    wire [31:0] B_adder;
    wire [31:0] ctrl;
    genvar i;
	generate
		for(i=0;i<32;i=i+1)begin: gen_for_0
			assign ctrl[i] = ctrl_in;
		end
	endgenerate
    assign B_adder = B_in ^ ctrl;
    wire C_out;
    bit_32_mixed_adder_8 _adder_(.A_in(A_in), .B_in(B_adder), .C_in(ctrl_in),
        .S_out(S_out), .C_out(C_out), .AND_out(AND_out), .OR_out(OR_out),
        .XOR_out(XOR_out));
    assign err_out = C_out ^ ctrl_in;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:17:06 PM
// Design Name: 32-bit look ahead and carry propagate mixed adder
// Module Name: bit_32_mixed_adder_8
// Project Name: RISC32i_CPU
// Description: 32-bit ripple carry (8-bit look ahead carry adder) with and/or/xor output
// Dependencies: bit8_look_ahead_carry_adder
//////////////////////////////////////////////////////////////////////////////////


module bit_32_mixed_adder_8(
    input [31:0] A_in,
    input [31:0] B_in,
    input C_in,
    output [31:0] AND_out,
    output [31:0] OR_out,
    output [31:0] XOR_out,
    output [31:0] S_out,
    output C_out
    );
    wire [32:0] carry;
	assign carry[0] = C_in;
	assign C_out = carry[32];
	
    genvar i;
    generate
        for(i=0;i<32;i=i+8)begin
            bit8_look_ahead_carry_adder _adder_(.A_in(A_in[i+7:i]), .B_in(B_in[i+7:i]), .C_in(carry[i]), .AND_out(AND_out[i+7:i]), 
				.OR_out(OR_out[i+7:i]), .XOR_out(XOR_out[i+7:i]), .S_out(S_out[i+7:i]), .C_out(carry[i+8]));
        end
    endgenerate
endmodule

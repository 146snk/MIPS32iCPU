`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:17:06 PM
// Design Name: LASALU
// Module Name: las_alu
// Project Name: RISC32i_CPU
// Description: 32-bit Arithmetic logic unit (LASALU type) 
//// supported instructions:
//// ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, LUI
// Dependencies: bit32_add_sub, bit_32_mixed_adder_8, bit8_look_ahead_carry_adder
//////////////////////////////////////////////////////////////////////////////////


module las_alu(
    input [31:0] A_in,
    input [31:0] B_in,
    input [3:0] aluop,
    output reg [31:0] ALU_out,
    output overflow_out,
    output zero_out
    );
    // control sub
    wire B_ctrl;
	assign B_ctrl = (aluop[2:1] == 2'b01)?1:0;
	
    // Add-sub mapping
	wire [31:0] S_out;
    wire [31:0] AND_out;
    wire [31:0] OR_out;
    wire [31:0] XOR_out;
    wire [31:0] SLT_out;
    bit32_add_sub _add_sub_(.A_in(A_in), .B_in(B_in), .ctrl_in(B_ctrl),
		.AND_out(AND_out), .OR_out(OR_out), .XOR_out(XOR_out), .S_out(S_out),
		.err_out(overflow_out));
	
	// LUI
	wire [31:0] LUI_out;
	assign LUI_out = {B_in[15:0], 16'b0};
	// aluop output control: 
    // 0000,0001 	- ADD/ADDU
    // 0010,0011 	- SUB/SUBU
    // 0100 		- AND
    // 0101 		- OR
    // 0110 		- XOR
    // 0111 		- NOR
    // 1010,1011 	- SLT/SLTU
	// 1111 		- LUI
    // otherwise 	- '0'
	always @(*) begin
		case(aluop)
			4'b0000,4'b0001, 4'b0010, 4'b0011: // ADD, ADDU, SUB, SUBU
				ALU_out = S_out;
			4'b0100: // AND
				ALU_out = AND_out;
			4'b0101: // OR
				ALU_out = OR_out;
			4'b0110: // XOR
				ALU_out = XOR_out;
			4'b0111: // NOR
				ALU_out = ~OR_out;
			4'b1010, 4'b1011: // SLT, SLTU -> overflow bit of ALU
				ALU_out = {31'd0 , overflow_out};
			4'b1111: // LUI
				ALU_out = LUI_out;
			default: // otherwise
				ALU_out = 32'dx;
		endcase
	end
	// zero out: NOR all bits
	assign zero_out = !(|ALU_out);
	
endmodule
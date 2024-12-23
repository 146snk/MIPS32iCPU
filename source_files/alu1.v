`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Design Name: ALU
// Module Name: alu1
// Project Name: RISC32i_CPU
// Description: 32-bit Arithmetic Shift Logic Unit
//// supported instructions:
//// ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, LUI,
//// SLL. SRL, SRA, SLLV, SRLV, SRAV
// Dependencies: las_alu, bit32_add_sub, bit_32_mixed_adder_8, bit8_look_ahead_carry_adder
////                shifter
//////////////////////////////////////////////////////////////////////////////////

module alu1(
    input [31:0] A_in,
    input [31:0] B_in,
    input [5:0] aluop,
    input [4:0] shamt,
    output [31:0] ALU_out,
    output zero_out,
    output overflow_out
    );
    // assign las_alu
    wire [31:0] las_alu_out;
    las_alu _alu_(.A_in(A_in), .B_in(B_in), .aluop(aluop[3:0]), .ALU_out(las_alu_out), .zero_out(zero_out), .overflow_out(overflow_out));
    // assign shifter
    //// shamt shift vs variable shift 
    wire [31:0] shift_data;
    assign shift_data = aluop[2]? A_in: B_in;
    wire [4:0] shift_shamt;
    assign shift_shamt = aluop[2]? B_in : shamt;
    wire [31:0] shift_out;
    shifter _shifter_(.data_in(shift_data), .shamt(shift_shamt), .shiftop(aluop[1:0]), .shift_out(shift_out));
	// choose lasalu or shift
	assign ALU_out = aluop[5]? las_alu_out : shift_out;
endmodule

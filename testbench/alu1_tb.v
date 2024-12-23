`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2024 05:11:29 PM
// Design Name: 
// Module Name: alu1_tb
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


module alu1_tb(

    );
	reg [31:0] tb_A_in;
    reg [31:0] tb_B_in;
    reg [5:0] tb_aluop;
    reg [4:0] tb_shamt;
    wire [31:0] tb_ALU_out;
    wire tb_overflow_out;
    wire tb_zero_out;
	
	alu1 dut(.A_in(tb_A_in),.B_in(tb_B_in), .aluop(tb_aluop), .shamt(tb_shamt),
		.ALU_out(tb_ALU_out), .overflow_out(tb_overflow_out), .zero_out(tb_zero_out));
	
	initial begin
		tb_shamt = 5'd6;
		//// LASALU
		tb_A_in = {24'd0,8'b00010110}; tb_B_in = {24'd0,8'b00001111}; 
		// 100000 - ADD, also for Load/Store
		tb_aluop = 6'b100000; #1
		// 100010 - SUB
		tb_aluop = 6'b100010; #1
		// 100100 - AND
		tb_aluop = 6'b100100; #1
		// 100101 - OR
		tb_aluop = 6'b100101; #1
		// 100110 - XOR
		tb_aluop = 6'b100110; #1
		// 100111 - NOR
		tb_aluop = 6'b100111; #1
		// 101010 - SLT
		tb_aluop = 6'b101010; #1;
		//// LUI
		tb_aluop = 6'b101111; #1
		//// Shifter
		tb_A_in = 32'hff00f000; 
		// SLL
		tb_aluop = 6'b000000; #1
		// SRL
		tb_aluop = 6'b000010; #1
		// SRA
		tb_aluop = 6'b000011; #1
		// SLLV
		tb_aluop = 6'b000100; #1
		//SRLV
		tb_aluop = 6'b000110; #1
		//SRAV
		tb_aluop = 6'b000111; #1;
		
	end
endmodule

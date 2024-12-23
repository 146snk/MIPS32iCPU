`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:17:06 PM
// Design Name: MIPS32ISA control unit
// Module Name: mips32i_ctrl
// Project Name: RISC32i_CPU - MIPS32i
// Description: 32-bit adder & subtractor with and/or/xor output
//// supported instructions:
//// ADD, SUB, AND, OR, XOR, NOR, SLT
// Dependencies: none
//////////////////////////////////////////////////////////////////////////////////


module mips32i_ctrl(
    input [5:0] opcode,
    input [5:0] funct,
    output reg [5:0] aluop,
    output reg inst_type_R0_I1,
    output reg imm_signext0_zeroext1,
	output reg reg_wt_en,
	output reg mem_wt_en,
	output reg mem_rd_en,
	output reg [1:0] reg_wt_sel,
	output reg [1:0] next_PC_ctrl
    );
    always @(*) begin
		// default
		reg_wt_en = 1; 	// reg write default en
		reg_wt_sel = 0;	// reg write default select ALU_out
		mem_rd_en = 0; 	// reg read default not en
		mem_wt_en = 0; 	// mem write default not en
		imm_signext0_zeroext1 = 0; // default sign_ext_immediate
		next_PC_ctrl = 2'b00; // default next PC = PC+4
			// next_PC 	= PC+4 	if 0
			// 			= j 	if 1
			//			= beq 	if 2
			//			= bne 	if 3
	
        if(opcode == 6'd0) begin // R-type
            aluop = funct;
            inst_type_R0_I1 = 0;
		end
		else if(opcode[5:1] == 00001) begin // J-type
			next_PC_ctrl = 2'b01; // J-type -> jump target
			if(opcode[0])	// jal
				reg_wt_sel = 2'b10;
		end
        else begin // I-type
            inst_type_R0_I1 = 1;
			if(opcode[5:1] == 5'b00010) begin// Branch inst.
				aluop = 6'b100010;	// sub -> zero
				inst_type_R0_I1 = 0;
				if(opcode[0] == 0)	// beq
					next_PC_ctrl = 2'b10;
				else				// bne
					next_PC_ctrl = 2'b11;
			end
			else if(opcode[5:4] == 2'b10) begin // Load/Store -> set to add op
				aluop = 6'b100000; 
				if (opcode[3] == 0) begin// Load -> reg_wt_sel MEM_out
					reg_wt_sel = 2'b01;
					mem_rd_en = 1;
                end           
				else begin // Store -> reg_wt_en not 
					reg_wt_en = 0;
					mem_wt_en = 1;
				end
			end
			else if (opcode[5:1] == 5'b00101) // SLT/SLTU
				aluop = {2'b10,opcode[3:0]};
			else if (opcode == 6'b001111) // LUI
				aluop = 6'b101111;
			else // other I-type
				aluop = {3'b100, opcode[2:0]};
			
			// immediate
			if (opcode[5:2] == 4'b0011 | opcode[5:1] == 5'b10000)	// zero_ext_immediate
				imm_signext0_zeroext1 = 1;
		end
    end
endmodule

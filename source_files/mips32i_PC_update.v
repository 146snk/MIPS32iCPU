`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Design Name: PC update
// Module Name: mips32i_PC_update
// Project Name: RISC32i_CPU
// Description: update PC for normal, branch and jump instructions
//////////////////////////////////////////////////////////////////////////////////


module mips32i_PC_update(
    input [31:0] PC_plus4,
    input [31:0] ext_immediate,
    input [25:0] j_immediate,
    input [1:0] next_PC_ctrl,
    input zero,
    output reg [31:0] next_PC
    );
    wire [31:0] branch_target;
    assign branch_target = PC_plus4 + (ext_immediate<<2);
    
    always @(*)begin
		case(next_PC_ctrl) 
			2'b00: next_PC <= PC_plus4;		// normal instruction
			2'b01: next_PC <= {PC_plus4[31:28],j_immediate,2'b00};	// jump
			2'b10:                          // beq
				if(zero) next_PC <= branch_target;  // taken
				else next_PC <= PC_plus4;           // not taken
			2'b11:                          // bne
				if(zero) next_PC <= PC_plus4;       // taken            
				else next_PC <= branch_target;      // not taken     
		endcase
	end
endmodule

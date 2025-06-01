`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Design Name: MIPS32i Single Cycle CPU
// Module Name: MIPS32i_SingleCycle
// Project Name: RISC32i_CPU
// Description: MIPS32i Single Cycle CPU
//// supported instructions:
//// ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, LUI,
//// SLL. SRL, SRA, SLLV, SRLV, SRAV
//// LW, SW
//////////////////////////////////////////////////////////////////////////////////

module mips32i_SingleCycle(
    input [31:0] inst_in,
	input [31:0] data_in,
    output [31:0] data_out,
    output [31:0] address_out,
	output mem_wt_en,
	output mem_rd_en,
	output [1:0] mem_size_sel,
    output reg [31:0] PC_out,
    input clk,
    input rst
    );
	// PC
	wire [31:0] next_PC;
	always @(posedge clk or posedge rst) begin
		if(rst) PC_out <= 0;
		else PC_out <= next_PC;
	end
	
	// decoder
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] immediate;
    wire [25:0] j_immediate;
    mips32i_decoder _decoder_(
        .instruction(inst_in), 
		.opcode(opcode),
		.rs(rs),
		.rt(rt),
		.rd(rd),
		.shamt(shamt),
		.funct(funct),
		.immediate(immediate),
		.j_immediate(j_immediate)
	);
    
	// control
	wire [5:0] aluop;
    wire inst_type_R0_I1;
    wire imm_signext0_zeroext1;
	wire reg_wt_en;
	wire [1:0] reg_wt_sel;
	wire [1:0] next_PC_ctrl;
    mips32i_ctrl _control_(
		.opcode(opcode),
		.funct(funct),
		.aluop(aluop),
		.inst_type_R0_I1(inst_type_R0_I1),
		.imm_signext0_zeroext1(imm_signext0_zeroext1),
		.reg_wt_en(reg_wt_en),
		.mem_wt_en(mem_wt_en),
		.mem_rd_en(mem_rd_en),
		.reg_wt_sel(reg_wt_sel),
		.next_PC_ctrl(next_PC_ctrl)
	);
	
	// register
	wire [4:0] Wt_addr;
	assign Wt_addr = inst_type_R0_I1? rt: rd;
	reg [31:0] Wt_data;
	wire [31:0] Rd_data_A;
	wire [31:0] Rd_data_B;
	reg32 _register_(
		.Rd_addr_A(rs),
		.Rd_addr_B(rt),
		.Wt_addr(Wt_addr),
		.Wt_data(Wt_data),
		.Wt_en(reg_wt_en),
		.Rd_data_A(Rd_data_A),
		.Rd_data_B(Rd_data_B),
		.clk(clk),
		.rst(rst)
	);
	
	// immediate
	wire [31:0] ext_immediate;
	mips32i_ext_immediate _extended_immediate_(
		.immediate(immediate),
		.imm_signext0_zeroext1(imm_signext0_zeroext1),
		.ext_immediate(ext_immediate)
	);
	
	// ALU
	wire [31:0] ALU_B_in;
	assign ALU_B_in = inst_type_R0_I1 ? ext_immediate : Rd_data_B;
    wire [31:0] ALU_out;
	wire zero_out;
	wire overflow_out;
	alu1 _alu_(
		.A_in(Rd_data_A), 
		.B_in(ALU_B_in),
		.aluop(aluop), 
		.shamt(shamt), 
		.ALU_out(ALU_out),
		.zero_out(zero_out),
		.overflow_out(overflow_out)
	);
	
	// PC update
	wire [31:0] PC_plus4;
	assign PC_plus4 = PC_out+4;
	mips32i_PC_update _PC_update_ (
		.PC_plus4(PC_plus4),
		.ext_immediate(ext_immediate),
		.j_immediate(j_immediate),
		.next_PC_ctrl(next_PC_ctrl),
		.zero(zero_out),
		.next_PC(next_PC)
	);
	
	// Data Memory
	assign address_out = ALU_out;
	assign data_out = Rd_data_B;
	assign mem_size_sel = opcode[1:0];
	always @(*) begin
		case(reg_wt_sel[1:0])
			2'b00: Wt_data <= ALU_out;
			2'b01: Wt_data <= data_in;
			2'b10: Wt_data <= PC_plus4;
			default: Wt_data <= 32'd0;
		endcase
	end
endmodule

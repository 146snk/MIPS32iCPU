`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 12:40:57 PM
// Design Name: 
// Module Name: mips32i_SingleCycle_tb
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


module mips32i_SingleCycle_tb(
    );
    reg [31:0] tb_inst_in;
    wire [31:0] tb_data_out;
    wire [31:2] tb_address_out;
    wire tb_mem_wt_en;
    reg [31:0] tb_data_in;
    reg tb_clk;
    reg tb_rst;
    
    reg [31:0] data_memory [0:16384];
    
    
    mips32i_SingleCycle dut(.inst_in(tb_inst_in), .data_out(tb_data_out), 
        .address_out(tb_address_out), .mem_wt_en(tb_mem_wt_en), .data_in(tb_data_in),
        .clk(tb_clk), .rst(tb_rst));
    
	always @(negedge tb_clk)begin
		if(tb_mem_wt_en == 1)
			data_memory[tb_address_out] <= tb_data_out;
	end
	always @(posedge tb_clk)begin
		tb_data_in = data_memory[tb_address_out];
	end
	
	integer i;
    initial begin
        tb_data_in <= 0;
        tb_clk <= 0; 
        for(i=0;i<16384;i=i+1)begin
            data_memory[i] <= 0;
        end
        forever #1 tb_clk = ~tb_clk;
    end
    initial begin
        tb_rst <= 1; #1 tb_rst <= 0;
        // addi $s0, $zero, 22
        tb_inst_in = 32'h20100016; #2
        // addi $t1, $zero, 15
        tb_inst_in = 32'h2009000F; #2
        // add $s1, $s0, $t1
        tb_inst_in = 32'h02098820; #2
        // addu $s1, $s0, $t1
        tb_inst_in = 32'h02098821; #2
        // sub $t2, $s0, $t1
        tb_inst_in = 32'h02095022; #2
        // subu $s1, $s0, $t1
        tb_inst_in = 32'h02098823; #2
        // andi $s1, $t1, 0x3c
        tb_inst_in = 32'h3131003C; #2
        // and $s1, $s0, $t1
        tb_inst_in = 32'h02098824; #2
        // or $s1, $s0, $t1
        tb_inst_in = 32'h02098825; #2
        // ori $s1, $t1, 0x3c
        tb_inst_in = 32'h3531003C; #2
        // xor
        tb_inst_in = 32'h02098826; #2
        // xori $s1, $t1, 0x3c
        tb_inst_in = 32'h3731003C; #2
        // nor $s1, $s0, $t1
        tb_inst_in = 32'h02098827; #2
        // slt $s1, $s0, $t1
        tb_inst_in = 32'h0130902A; #2
        // slti $s2, $t1, 10
        tb_inst_in = 32'h2932000A; #2
        // sltu $s1, $s0, $t1
        tb_inst_in = 32'h0130902B; #2
        // sltui $s2, $t1, 10
        tb_inst_in = 32'h2D32000A; #2
        // lui $s2, $zero, 0xf00f
        tb_inst_in = 32'h3c12f00f; #2
        // sll $s3, $s2, 6
        tb_inst_in = 32'h00129980; #2
        // srl $s3, $s2, 6
        tb_inst_in = 32'h00129982; #2
        // sra $s3, $s2, 6
        tb_inst_in = 32'h00129983; #2
        // sllv $s3, $s2, $t3
        tb_inst_in = 32'h024a9984; #2
        // srlv $s3, $s2, $t3
        tb_inst_in = 32'h024a9986; #2
        // srrv $s3, $s2, $t3
        tb_inst_in = 32'h024a9987; #2
        // sw $s3, 0($zero)
        tb_inst_in = 32'hac130000; #2
        // lb
        
        // lbu
        
        // lh
        
        // lhu
        
        // lw
        tb_inst_in = 32'h8c940000;
        // sb
        
        // sh
        
        
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2024 07:34:18 PM
// Design Name: 
// Module Name: SingleCycleTop
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


module SingleCycleTop(
    );
	// I/O components
    wire [31:0] inst;
    wire [31:0] data_out;
    wire [31:0] address;
	wire mem_wt_en;
	wire mem_rd_en;
	wire [1:0] mem_size_sel;
	wire [31:0] PC;
    reg [31:0] data_in;
    reg clk;
    reg rst;
    // data memory
	reg [31:0] data_memory [0:16383];
	//// WB
	always @(negedge clk)
		if(mem_wt_en == 1)
			case(mem_size_sel)
				2'b00: // SB
                    case(address[1:0])
					   2'b00: data_memory[address[31:2]][7:0] <= data_out[7:0];
					   2'b01: data_memory[address[31:2]][15:8] <= data_out[7:0];
					   2'b10: data_memory[address[31:2]][23:16] <= data_out[7:0];
					   2'b11: data_memory[address[31:2]][31:24] <= data_out[7:0];
                    endcase           
				2'b01: // SH
				    case(address[1:0])
				        2'b00: data_memory[address[31:2]][15:0] <= data_out[15:0];
				        2'b01: data_memory[address[31:2]][23:8] <= data_out[15:0];
				        2'b10: data_memory[address[31:2]][31:16] <= data_out[15:0];
				    endcase
				2'b11: // SW
					data_memory[address[31:2]] <= data_out;
			endcase
	//// RD
	always @(*)begin
		if(mem_rd_en == 1)
			case(mem_size_sel)
				2'b00: // LB
					case(address[1:0])
					   2'b00: data_in <= {24'b0,data_memory[address[31:2]][7:0]};
					   2'b01: data_in <= {24'b0,data_memory[address[31:2]][15:8]};
					   2'b10: data_in <= {24'b0,data_memory[address[31:2]][23:16]};
					   2'b11: data_in <= {24'b0,data_memory[address[31:2]][31:24]};
                    endcase 
				2'b01: // LH
					case(address[1:0])
				        2'b00: data_in <= {16'b0,data_memory[address[31:2]][15:0]};
				        2'b01: data_in <= {16'b0,data_memory[address[31:2]][23:8]};
				        2'b10: data_in <= {16'b0,data_memory[address[31:2]][31:16]};
				    endcase
				2'b11: // LW
					data_in <= data_memory[address[31:2]];
			endcase
	end
	
	
	// map cpu
	mips32i_SingleCycle _CPU_(.inst_in(inst), 
		.data_out(data_out),
		.address_out(address),
		.mem_wt_en(mem_wt_en),
		.mem_rd_en(mem_rd_en),
		.mem_size_sel(mem_size_sel),
		.data_in(data_in),
		.PC_out(PC),
		.clk(clk),
		.rst(rst)
	);
	
	// init reset
	integer i;
	initial begin
        clk <= 0; 
        forever #1 clk = ~clk;
    end
	
	// Instruction memory
	reg [31:0] inst_memory [16383:0];
	initial begin
		$readmemh("ROM_data.txt", inst_memory);
		data_in <= 0;
		for(i=0;i<16384;i=i+1)begin
            data_memory[i] <= 0;
        end
		rst <= 1; #1 rst <= 0;	
	end
	assign inst = inst_memory[PC[15:2]];
	
endmodule

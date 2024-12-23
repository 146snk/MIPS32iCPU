`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2024 09:53:46 PM
// Design Name: 
// Module Name: reg32_tb
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


module reg32_tb(
    );
	reg [4:0] tb_Rd_addr_A;
    reg [4:0] tb_Rd_addr_B;
    reg [4:0] tb_Wt_addr;
    reg [31:0] tb_Wt_data;
    reg tb_Wt_en;
    wire [31:0] tb_Rd_data_A;
    wire [31:0] tb_Rd_data_B;
    reg tb_clk;
    reg tb_rst;
	
	reg32 dut(.Rd_addr_A(tb_Rd_addr_A), .Rd_addr_B(tb_Rd_addr_B), .Wt_addr(tb_Wt_addr), .Wt_data(tb_Wt_data), 
		.Wt_en(tb_Wt_en), .Rd_data_A(tb_Rd_data_A), .Rd_data_B(tb_Rd_data_B), .clk(tb_clk), .rst(tb_rst));
		
	initial begin
		tb_clk = 0;
        forever #1 tb_clk = ~tb_clk;
	end
	initial begin
		tb_rst = 1; #1 ; 
		tb_Rd_addr_A = 0; tb_Rd_addr_B = 0; tb_Wt_addr = 0; tb_Wt_data = 0; tb_Wt_en = 0;
		tb_rst = 0; #1
		tb_Wt_addr = 5'd15; tb_Wt_data = 32'd1234; tb_Wt_en = 1; 
		#2
		tb_Wt_addr = 5'd7; tb_Wt_data = 32'd5678; tb_Wt_en = 1; 
		tb_Rd_addr_A = 5'd15;
		#2
		tb_Wt_en = 0; tb_Rd_addr_A = 5'd7; tb_Rd_addr_B = 5'd15;
		#2 
		tb_Wt_addr = 0; tb_Wt_data = 5; tb_Wt_en = 1;
	end
endmodule

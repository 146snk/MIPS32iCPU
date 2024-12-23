`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HKUST RCSL
// Engineer: 146snk
// 
// Create Date: 11/24/2024 04:17:06 PM
// Design Name: 32x 32-bit registeer
// Module Name: reg32
// Project Name: RISC32i_CPU
// Description: 32x 32-bit register with 2 read port and 1 write port with write enable
// Dependencies: none
//////////////////////////////////////////////////////////////////////////////////


module reg32(
    input [4:0] Rd_addr_A,
    input [4:0] Rd_addr_B,
    input [4:0] Wt_addr,
    input [31:0] Wt_data,
    input Wt_en,
    output [31:0] Rd_data_A,
    output [31:0] Rd_data_B,
    input clk,
    input rst
    );
    reg [31:0] register [31:0];
    integer i;
    
    // read
    assign Rd_data_A = (Rd_addr_A == 0) ? 0 : register[Rd_addr_A]; 	  // read
	assign Rd_data_B = (Rd_addr_B == 0) ? 0 : register[Rd_addr_B];    // read
    
    always @(negedge clk or posedge rst)begin
        // asynchronous reset
        if (rst == 1) begin
            for(i=0;i<32;i=i+1)begin
                register[i]<=0;
            end
        end
        // write
        else begin
            if(Wt_addr != 0 && Wt_en == 1) begin
                register[Wt_addr] <= Wt_data;
            end
        end
    end  
endmodule

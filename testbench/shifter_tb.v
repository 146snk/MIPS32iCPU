`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 05:53:12 PM
// Design Name: 
// Module Name: shifter_tb
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


module shifter_tb(
    );
    reg [31:0] tb_rs;
    reg [31:0] tb_rt;
    reg [4:0] tb_shamt_in;
    reg [2:0] tb_shiftop;
    wire [31:0] tb_shift_out;
    
    shifter dut(.rs(tb_rs), .rt(tb_rt), .shamt_in(tb_shamt_in), .shiftop(tb_shiftop), 
        .shift_out(tb_shift_out));
    
    initial begin
        tb_rs = 32'hff00f000;
        tb_rt = 32'hff000002;
        tb_shamt_in = 5'd6;
        
        tb_shiftop = 3'b000; #1
        tb_shiftop = 3'b010; #1
        tb_shiftop = 3'b011; #1
        tb_shiftop = 3'b100; #1
        tb_shiftop = 3'b110; #1
        tb_shiftop = 3'b111;
    end
endmodule

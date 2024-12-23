`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/17/2024 12:05:53 PM
// Design Name: 
// Module Name: mips32i_ext_immediate
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


module mips32i_ext_immediate(
    input [15:0] immediate,
    input imm_signext0_zeroext1,
    output [31:0] ext_immediate
    );
    // sign_ext_immediate
    wire [31:0] sign_ext_immediate;
    assign sign_ext_immediate = {{16{immediate[15]}},immediate};
    // zero_ext_immediate
    wire [31:0] zero_ext_immediate;
    assign zero_ext_immediate = {16'd0,immediate};
    // select immediate
    assign ext_immediate = imm_signext0_zeroext1 ? zero_ext_immediate : sign_ext_immediate;
endmodule

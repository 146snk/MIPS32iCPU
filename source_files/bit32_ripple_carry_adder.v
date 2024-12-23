`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 09:14:26 PM
// Design Name: 
// Module Name: bit32_ripple_carry_adder
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


module bit32_ripple_carry_adder(
    input [31:0] A_in,
    input [31:0] B_in,
    input C_in,
    output [31:0] S_out,
    output C_out
    );
    wire carry[32:0];
    assign carry[0] = C_in;
    assign C_out = carry[32];
    genvar i;
    generate
        for (i=0;i<32;i=i+1)begin
            full_adder FA(.A_in(A_in[i]), .B_in(B_in[i]), .C_in(carry[i]), .S_out(S_out[i]), .C_out(carry[i+1]));
        end
    endgenerate
endmodule

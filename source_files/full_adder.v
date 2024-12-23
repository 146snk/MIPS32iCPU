`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 08:51:06 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input A_in,
    input B_in,
    input C_in,
    output S_out,
    output C_out
    );
    wire ha1_C_out, ha1_S_out, ha2_C_out;
    half_adder HA1(.A_in(A_in), .B_in(B_in), .S_out(ha1_S_out), .C_out(ha1_C_out));
    half_adder HA2(.A_in(C_in), .B_in(ha1_S_out), .S_out(S_out), .C_out(ha2_C_out));
    assign C_out = ha1_C_out | ha2_C_out;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 05:39:07 PM
// Design Name: 
// Module Name: shifter
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


module shifter(
    input [31:0] data_in,
    input [4:0] shamt,
    input [1:0] shiftop,
    output reg  [31:0] shift_out
    );
    // for SRA
    wire signed [31:0] signed_data_in;
    assign signed_data_in = data_in;
    always@(*)begin
        case(shiftop[1:0])
            // SLL
            2'b00: shift_out = data_in << shamt;
            // SRL
            2'b10: shift_out = data_in >> shamt;
            // SRA
            2'b11: shift_out = signed_data_in >>> shamt;
            // default
            default: shift_out = 32'hx;
        endcase
    end
endmodule

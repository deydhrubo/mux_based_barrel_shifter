`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2026 10:54:54 PM
// Design Name: 
// Module Name: data_reversal
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


module data_reversal#(
    parameter bits = 8
)
(
    input [bits-1:0] I,
    input left,
    output reg [bits-1:0] O
    );

    integer i;
    always @(*) begin
        O = I;
        if (left) begin
            for (i = 0; i<bits ; i=i+1) begin
                O[i] = I[bits-i-1];
            end
        end
    end
endmodule

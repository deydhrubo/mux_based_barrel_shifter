`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2026 12:30:29 AM
// Design Name: 
// Module Name: barrel_shifter_top
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


module barrel_shifter_top #(
    parameter bits = 8,
    parameter stages = $clog2(bits)
)(
    input [bits-1:0] I,
    input [stages-1:0] S,
    input sla, sra, rotate, left,
    output [bits-1:0] O,
    output overflow
);

wire [bits-1:0] ro1, co;
//module instantiation
data_reversal #(.bits(bits)) reversal1(.I(I), .O(ro1), .left(left));

right_shifter_rotator #(.bits(bits)) shifter_core(
    .I(ro1), .S(S), .sla(sla), .sra(sra), .rotate(rotate),
    .O(co), .overflow(overflow)
);

data_reversal #(.bits(bits)) reversal2(.I(co), .O(O), .left(left));
endmodule

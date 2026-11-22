`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2026 07:44:55 PM
// Design Name: 
// Module Name: right_shifter_rotator
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


module right_shifter_rotator
#(
    parameter bits = 8,
    parameter stages = $clog2(bits)
)
(
    input [bits-1:0] I,
    input [stages-1:0] S,
    input sra,
    input sla,
    input rotate,
    output reg [bits-1:0] O,
    output overflow
    );
    reg [bits-1:0] Q;
    reg ovf;
    integer i, n, j;
    always @(*) begin
        Q = I;
        ovf = 1'b0;
        for (i = stages-1; i>=0 ; i=i-1) begin
            if (S[i]) begin
                n = 2**i;
                for (j=1 ; j<=n ; j=j+1) begin
                    ovf = ovf | (Q[j]^I[0]);
                end
                    
                if (rotate) begin
                    Q = (Q>>n) | (Q<<(bits-n));
                end
                else if (!sra) begin
                     Q = Q>>n;
                end
                else begin
                    Q = $signed(Q)>>>n;
                end
            end
        end
        O = Q;
        O[0] = sla? I[0] : Q[0];
    end

    assign overflow = sla & ovf;
endmodule

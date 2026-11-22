`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2026 01:35:25 AM
// Design Name: 
// Module Name: tb_barrel_shifter_top
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


module tb_barrel_shifter_top;

reg [7:0] in;
reg [2:0] stage;
reg sla, sra, ror, rev;
wire [7:0] out;
wire overflow;

barrel_shifter_top #(.bits(8)) DUT(in, stage, sla, sra, ror, rev, out, overflow);

initial begin
    in = 8'd0;
    stage = 3'd0;
    sla = 0;
    sra = 0;
    ror = 0;
    rev = 0;
end

//shift-right logical
initial begin
    // shift-right logical (sla=0 sra=0 ror=0 rev=0)
    #2 in = 8'd10;
    #2 stage = 3'b010;                          
    #2 in = 8'd15; stage = 3'b000;
    #2 stage = 3'b101;                          

    // shift-right arithmetic (sra=1)
    #2 sla = 0; sra = 1; ror = 0; rev = 0;
       in = 8'b10010000; stage = 3'd0;
    #2 stage = 3'd2;                         
    #2 in = 8'b01100100; stage = 3'd0;
    #2 stage = 3'd3;                            

    // rotate right (ror=1)
    #2 sla = 0; sra = 0; ror = 1; rev = 0;
       in = 8'b10110001; stage = 3'd0;
    #2 stage = 3'd3;                            
    #2 in = 8'b00001111; stage = 3'd0;
    #2 stage = 3'd5;                            

    // shift-left logical (rev=1)
    #2 sla = 0; sra = 0; ror = 0; rev = 1;
       in = 8'd10; stage = 3'd0;
    #2 stage = 3'd2;                            
    #2 in = 8'b11010110; stage = 3'd0;
    #2 stage = 3'd3;                            

    // rotate left (rev=1, ror=1)
    #2 sla = 0; sra = 0; ror = 1; rev = 1;
       in = 8'b10010110; stage = 3'd0;
    #2 stage = 3'd3;                            
    #2 in = 8'b00000001; stage = 3'd0;
    #2 stage = 3'd7;                            

    // shift-left arithmetic (sla=1, rev=1)
    #2 sla = 1; sra = 0; ror = 0; rev = 1;
       in = 8'b11111100; stage = 3'd0;          
    #2 stage = 3'd3;                             
    #2 in = 8'd48; stage = 3'd0;
    #2 stage = 3'd2;                            

    #10 $finish;
end

initial begin
    $monitor("t=%0t | in=%b (%0d) | left=%b rotate=%b sra=%b sla=%b | S=%0d | out=%b (%0d) | ovf=%b",
             $time, in, in, rev, ror, sra, sla, stage, out, out, overflow);
end
endmodule

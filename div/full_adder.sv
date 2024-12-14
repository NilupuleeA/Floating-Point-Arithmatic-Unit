`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2024 15:54:30
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
    input logic a,
    input logic b,
    input logic c_in,
    output logic c_out,
    output logic sum
    ); 

    logic wire_1, wire_2, wire_3;
    
    assign wire_1 = a^b;
    assign wire_2 = wire_1 & c_in;

    always_comb begin
        wire_3 = a & b;
    end

    assign sum = wire_1 ^ c_in;
    assign c_out = wire_2 | wire_3;
endmodule

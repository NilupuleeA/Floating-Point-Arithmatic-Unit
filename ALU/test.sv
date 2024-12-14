`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2024 19:32:54
// Design Name: 
// Module Name: test
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


module test(
    input logic clk, rstn,
    input logic [1:0] op,
    output logic [31:0] result 
    );

    logic [31:0] number1, number2;

    assign number1 = 31'b00111111100011100001010001111011;
    assign number2 = 31'b00111111100000010100011110101110;

    fp_alu alu(
        .clk(clk), 
        .rstn(rstn),
        .num1(number1),
        .num2(number2),
        .op(op),  // 2-bit input operation code
        .S(result)
    );
endmodule

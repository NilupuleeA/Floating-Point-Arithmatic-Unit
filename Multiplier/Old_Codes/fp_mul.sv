`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2024 17:08:31
// Design Name: 
// Module Name: fp_mul
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


module fp_mul(
    input logic clk, rstn,
    input logic [31:0] num1,
    input logic [31:0] num2,
    // input logic op,
    output logic [31:0] S 
); 
    logic sign1, sign2, sign;
    logic [22:0] frac1, frac2; 
    logic [7:0] expo1, expo2, exp_diff;
    logic [22:0] fraction;
    logic [7:0] exponent;
    logic [46:0] result;

    assign sign1 = num1[31];
    assign sign2 = num2[31];
    assign frac1 = num1[22:0];
    assign frac2 = num2[22:0];
    assign expo1 = num1[30:23];
    assign expo2 = num2[30:23];

    multiplier fac (
        .clk(clk),
        .rstn(rstn),            
        .frac1(frac1),      
        .frac2(frac2),      
        .R(result)
    );

    assign exponent = expo1 + expo2 - 127;
    assign fraction = result[44:22];
    assign sign = sign1^sign2;

    assign S[31] = sign;
    assign S[30:23] = exponent;
    assign S[22:0] = fraction;
endmodule

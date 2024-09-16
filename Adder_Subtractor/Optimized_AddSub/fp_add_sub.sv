`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 12:50:12
// Design Name: 
// Module Name: fp_add_sub
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


module fp_add_sub(
    input logic clk, rstn,
    input logic [31:0] num1,
    input logic [31:0] num2,
    input logic op,
    output logic [31:0] S 
); 
    logic sign1, sign2, sign;
    logic [22:0] frac1, frac2; 
    logic [7:0] expo1, expo2, exp_diff;
    logic [7:0] exponent_temp;
    logic sel, sel2;
    logic [23:0] Shifted_val, nonShifted_val;
    logic [22:0] fraction;
    logic [7:0] exponent;

    assign sign1 = num1[31];
    assign sign2 = num2[31];
    assign frac1 = num1[22:0];
    assign frac2 = num2[22:0];
    assign expo1 = num1[30:23];
    assign expo2 = num2[30:23];

    // exponet_diff comp(
    //     .clk(clk),
    //     .frac1(frac1),
    //     .frac2(frac2),
    //     .expo1(expo1),
    //     .expo2(expo2),
    //     .exp_diff(exp_diff),
    //     .sel(sel)
    // );

    fraction fac (
        .clk(clk), 
        .rstn(rstn),
        .frac1(frac1),
        .frac2(frac2),
        //.exp_diff(exp_diff),
        .sel(sel),
        .expo1(expo1), 
        .expo2(expo2),
        .exponent_temp(exponent_temp),
        .Shifted_val(Shifted_val),
        .nonShifted_val(nonShifted_val)
    );

    addition add (
        .clk(clk), 
        .sel2(sel2), 
        .rstn(rstn),
        .Shifted_val(Shifted_val),
        .nonShifted_val(nonShifted_val),
        .fraction(fraction),
        .exponent_temp(exponent_temp),
        .exponent(exponent)
    );

    sign sg(
        .clk(clk), 
        .rstn(rstn), 
        .sel(sel),
        .sign1(sign1), 
        .sign2(sign2),
        .sel2(sel2),
        .op(op), 
        .sign(sign)
    );

    assign S[31] = sign;
    assign S[30:23] = exponent;
    assign S[22:0] = fraction;
  
endmodule


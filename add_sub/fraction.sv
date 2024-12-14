`timescale 1ns / 1ps

module fraction(
    input logic clk, rstn,
    input logic [22:0] frac1,
    input logic [22:0] frac2,
    input logic [7:0] expo1, expo2,
    output logic [23:0] Shifted_val,
    output logic [23:0] nonShifted_val,
    output logic [7:0] exponent_temp,
    output logic sel
    );

    logic [23:0] val1, val2;
    logic signed [7:0] exp_diff;  
    assign val1 = {1'b1, frac1};  
    assign val2 = {1'b1, frac2};  

    sub_8bit sub (
        .A(expo1),      
        .B(expo2),     
        .S(exp_diff)     
    );

    assign sel = (expo1 == expo2) ? (frac1 >= frac2 ? 1 : 0) : (exp_diff >= 0 ? 1 : 0);

    assign Shifted_val = (expo1 == expo2) 
                            ? (frac1 >= frac2 ? val2 : val1)
                            : (exp_diff >= 0 ? (val2 >> exp_diff) : (val1 >> -exp_diff));

    assign nonShifted_val = (expo1 == expo2) 
                            ? (frac1 >= frac2 ? val1 : val2)
                            : (exp_diff >= 0 ? val1 : val2);

    assign exponent_temp = (expo1 == expo2) 
                            ? (frac1 >= frac2 ? expo1 : expo2)
                            : (exp_diff >= 0 ? expo1 : expo2);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 15:27:52
// Design Name: 
// Module Name: fp_alu_tb
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

module fp_alu(
    input logic clk, 
    input logic rstn,
    input logic [31:0] num1,
    input logic [31:0] num2,
    input logic [1:0] op,  // 2-bit input operation code
    output logic [31:0] S 
);

    // Intermediate signals for each operation result
    //logic [31:0] S_add;
    logic [31:0] S_add_sub;
    logic [31:0] S_mul;
    logic [31:0] S_div;

    // // Instantiate the floating-point adder
    // fp_add_sub fp_add_inst(
    //     .clk(clk), 
    //     .rstn(rstn), 
    //     .num1(num1), 
    //     .num2(num2), 
    //     .op(1'b0),  // 0 for addition
    //     .S(S_add)
    // );

    // Instantiate the floating-point subtractor
    fp_add_sub fp_add_sub_inst(
        .clk(clk), 
        .rstn(rstn), 
        .num1(num1), 
        .num2(num2), 
        .op(op),  // 1 for subtraction
        .S(S_add_sub)
    );

    // Instantiate the floating-point multiplier
    fp_mul fp_mul_inst(
        .clk(clk), 
        .rstn(rstn),
        .num1(num1),
        .num2(num2),
        .S(S_mul)
    );

    // Instantiate the floating-point divider
    fp_div fp_div_inst(
        .clk(clk), 
        .rstn(rstn),
        .num1(num1),
        .num2(num2),
        .S(S_div)
    );

    // Combinational block to select the output based on the operation code
    always_comb begin
        case (op)
            2'b00: S = S_add_sub;   // Add
            2'b01: S = S_add_sub;   // Subtract
            2'b10: S = S_mul;   // Multiply
            2'b11: S = S_div;   // Divide
            default: S = 32'h00000000;  // Default: no operation
        endcase
    end

endmodule

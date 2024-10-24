`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 20:42:46
// Design Name: 
// Module Name: addition_tb
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


module addition_tb();
    localparam CLK_PERIOD = 10;
    logic clk, rstn = 0;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    logic sel2;
    logic [22:0] fraction;
    logic [31:0] num1;
    logic [31:0] num2;
    logic [23:0] Shifted_val, nonShifted_val;
    logic [7:0] exponent_temp;
    logic [7:0] exponent;

    fp_add_sub prev(.*);
    addition dut(.*);

    initial begin
        sel2 = 0;
        rstn = 0;
        num1 = 0;
        num2 = 0;

        #20; 
        rstn = 1;

        num1 = 32'd30;
        num2 = 32'd10;

        repeat(10) @(posedge clk);

        num1[0] = $random;
        num2[0] = $random;
        num1[31:23] = 8'd48;
        num2[31:23] = 8'd42;
        num1[22:0] = $random;
        num2[22:0] = $random;
        repeat(10) @(posedge clk);

    end
endmodule

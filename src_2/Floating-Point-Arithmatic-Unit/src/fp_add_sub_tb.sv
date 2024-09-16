`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 19:19:34
// Design Name: 
// Module Name: fp_add_sub_tb
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

module fp_add_sub_tb();
    localparam CLK_PERIOD = 10;
    logic clk, rstn;
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk; 
    end

    logic [31:0] num1;
    logic [31:0] num2;
    logic [31:0] S; 

    fp_add_sub dut (.*);

    initial begin
        rstn = 0;
        num1 = 0;
        num2 = 0;

        #20; 
        rstn = 1;

        num1 = 32'd30;
        num2 = 32'd10;

        repeat(20) @(posedge clk);

        num1[31] = 0;
        num2[31] = 1;
        num1[30:23] = 8'd48;
        num2[30:23] = 8'd42;
        num1[22:0] = $random;
        num2[22:0] = $random;
        repeat(20) @(posedge clk);

        num1[31] = 1;
        num2[31] = 0;
        num1[30:23] = 8'd48;
        num2[30:23] = 8'd42;
        num1[22:0] = $random;
        num2[22:0] = $random;
        repeat(20) @(posedge clk);

        num1[31] = 1;
        num2[31] = 0;
        num1[30:23] = 8'd42;
        num2[30:23] = 8'd42;
        num1[22:0] = $random;
        num2[22:0] = $random;
        repeat(20) @(posedge clk);

        num1[31] = 1;
        num2[31] = 0;
        num1[30:23] = 8'd125;
        num2[30:23] = 8'd126;
        num1[22:0] = $random;
        num2[22:0] = $random;
        repeat(20) @(posedge clk);

    end
endmodule

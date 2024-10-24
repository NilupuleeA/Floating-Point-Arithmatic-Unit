`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 14:36:21
// Design Name: 
// Module Name: fraction_tb
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


module fraction_tb();
    localparam CLK_PERIOD = 10;
    logic clk, rstn = 0;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    logic [7:0] expo1, expo2;
    logic [22:0] frac1;
    logic [22:0] frac2;
    logic [23:0] nonShifted_val, Shifted_val;
    //logic [7:0] exp_diff;
    logic sel;
    logic [7:0] exponent_temp;

    //exponet_diff step1(.*);
    fraction dut(.*);

    initial begin
        rstn <= 1;
        expo1 <= 8'd5;
        expo2 <= 8'd11;
        frac1 <= 23'd5;
        frac2 <= 23'd11;

        repeat(10) @(posedge clk);
        expo1 <= 8'd30;
        expo2 <= 8'd10;
        frac1 <= 23'd30;
        frac2 <= 23'd10;

        repeat(10) @(posedge clk);
        expo1 <= 8'd5;
        expo2 <= 8'd15;
        frac1 <= 23'd5;
        frac2 <= 23'd15;

        repeat(10) @(posedge clk);
        expo1 <= 8'd127;
        expo2 <= 8'd1; 
        frac1 <= 23'd127;
        frac2 <= 23'd1; 
    end
endmodule
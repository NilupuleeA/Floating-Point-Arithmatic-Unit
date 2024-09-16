`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 13:42:18
// Design Name: 
// Module Name: exponet_diff_tb
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


module exponet_diff_tb();
    localparam CLK_PERIOD = 10;
    logic clk;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    logic [7:0] expo1;
    logic [7:0] expo2;
    logic [7:0] exp_diff;
    logic sel;

    exponet_diff dut(.*);

    initial begin
        expo1 <= 8'd5;
        expo2 <= 8'd11;

        repeat(10) @(posedge clk);
        expo1 <= 8'd30;
        expo2 <= 8'd10;

        repeat(10) @(posedge clk);
        expo1 <= 8'd5;
        expo2 <= 8'd15;

        repeat(10) @(posedge clk);
        expo1 <= 8'd127;
        expo2 <= 8'd1; 
    end
endmodule


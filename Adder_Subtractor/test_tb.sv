`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.10.2024 15:45:21
// Design Name: 
// Module Name: test_tb
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


module test_tb();
    logic [31:0] result;
    logic clk, rstn;
    logic [1:0] op;

    localparam CLK_PERIOD = 10;

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    test dut (.*);

    initial begin
        rstn <= 0;
        @(posedge clk);
        rstn <= 1;
        op <= 2'd0; 

    repeat(100)
    #15 check_output(result, 32'b01000000000001111010111000010100);
    end

    
    task check_output;
        input [31:0] actual;
        input [31:0] expected;
        if (actual !== expected) begin
            $display("Test Failed: Expected %h, but got %h", expected, actual);
        end else begin
            $display("Test Passed: Output %h matches expected %h", actual, expected);
        end
    endtask
endmodule

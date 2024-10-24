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


module fp_alu_tb();
    localparam CLK_PERIOD = 10;
    logic clk, rstn;
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk; 
    end

    logic [31:0] num1;
    logic [31:0] num2;
    logic [31:0] S;
    logic [1:0] op; 

    fp_alu dut (.*);

    initial begin
        rstn <= 0;
        num2 <= 32'b0;
        num1 <= 32'b0;
        op <= 2'd0;
        @(posedge clk);
        rstn <=1;
        num1 <= 32'b01000000000100111101011100001010;
        num2 <= 32'b00111111100011110101110000101001;
        op <= 2'd0;
        
        repeat (10) 
        #15 check_output(S, 32'b01000000010110111000010100011110);       

        @(posedge clk);
        num1 <= 32'b00111110100111101011100001010010;
        num2 <= 32'b00111111100011110101110000101001;
        op <= 2'd1;
        repeat (10) 
        #15 check_output(S, 32'b10111111010011110101110000101010);

        @(posedge clk);
        num1 <= 32'b00111111110000010100011110101110;
        num2 <= 32'b00111111100000010100011110101110;
        op <= 2'd2;
        repeat (10) 
        #15 check_output(S, 32'b00111111110000110011011001111010);

        @(posedge clk);
        num2 <= 32'b00111111100011100001010001111011;
        num1 <= 32'b00111111100110101110000101001000;
        op <= 2'd3;

        repeat (10) 
        #15 check_output(S, 32'b00111111011010101101011111001101);
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
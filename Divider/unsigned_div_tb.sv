`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 18:02:25
// Design Name: 
// Module Name: unsigned_div_tb
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


module unsigned_div_tb();
    localparam CLK_PERIOD = 10;
    logic clk, rstn = 0;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    localparam N = 48;

    logic [N-1:0] M;
    logic [N-1:0] Q;
    logic [N/2-1:0] Quotient;
    logic [N/2-1:0] Remainder;

    //exponet_diff step1(.*);
    unsigned_div dut(.*);

    initial begin
        M <= 48'd2657890056;
        Q <= 48'd356478892927895;
        rstn <= 0;

        @(posedge clk);
        rstn <=1;
        
        
        repeat (70) 
        #15 check_output(Remainder, 12'd21);       
        //01000011000101101100011100010001

       @(posedge clk);
       M <= 48'b11000001001000011100001010001111;

       repeat (10) 
       #15 check_output(Remainder, 48'b11000001001100111000010100011110);
    end

    task check_output;
         input [11:0] actual;
         input [11:0] expected;
         if (actual !== expected) begin
             $display("Test Failed: Expected %h, but got %h", expected, actual);
         end else begin
             $display("Test Passed: Output %h matches expected %h", actual, expected);
         end
    endtask
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2024 04:08:48
// Design Name: 
// Module Name: multiplier_tb
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


module multiplier_tb();
    localparam CLK_PERIOD = 10;
    logic clk, rstn = 0;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    localparam N = 24;

    logic [N-2:0] frac1;
    logic [N-2:0] frac2;
    logic [2*N-2:0] R;

    //exponet_diff step1(.*);
    multiplier dut(.*);

    initial begin
        frac1 <= 23'd7;
        frac2 <= 23'd3;
        
        @(posedge clk);
        rstn <= 0;

        @(posedge clk);
        rstn <=1;
        
        
        repeat (10) 
        #15 check_output(R, 48'd21);       
        //01000011000101101100011100010001

//        @(posedge clk);
//        M <= 24'b11000001001000011100001010001111;
//        Q <= 24'b00111111100011100001010001111011;

//        repeat (10) 
//        #15 check_output(R, 24'b11000001001100111000010100011110);
    end

    task check_output;
         input [47:0] actual;
         input [47:0] expected;
         if (actual !== expected) begin
             $display("Test Failed: Expected %h, but got %h", expected, actual);
         end else begin
             $display("Test Passed: Output %h matches expected %h", actual, expected);
         end
    endtask
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2024 13:38:53
// Design Name: 
// Module Name: add_8bit_tb
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


module add_8bit_tb();
    timeunit 1ns;
    timeprecision 1ps;

    localparam CLK_PERIOD = 10;
    logic clk;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    localparam N = 8;

    logic [N-1:0] A, B, S;
    //logic c_out;

    sub_8bit #(.N(N)) dut (.*);

    initial begin
        A <= 8'd5;
        B <= 8'd10;

        @(posedge clk);
        A <= 8'd30;
        B <= -8'd10;

        @(posedge clk);
        A <= 8'd5;
        B <= 8'd10; 

        @(posedge clk);
        A <= 8'd127;
        B <= -8'd1; 

        repeat(10) begin
            @(posedge clk);
            std::randomize(A) with{
                A inside {[-128:127]};
            };
            std::randomize(B) with{
                B inside {[-128:127]};
            };
        end
    end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2024 23:14:53
// Design Name: 
// Module Name: addsub_24bit_tb
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


module addsub_24bit_tb();
    timeunit 1ns;
    timeprecision 1ps;

    localparam CLK_PERIOD = 10;
    logic clk;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk <= ~clk;
    end

    localparam N = 24;

    logic [N-1:0] A, B, S;
    logic c_in, c_out;

    addsub_24bit #(.N(N)) dut (.*);

    initial begin
        A <= 24'd5;
        B <= 24'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 24'd30;
        B <= -24'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 24'd5;
        B <= 24'd10;
        c_in <= 1;  

        @(posedge clk);
        A <= 24'd127;
        B <= -24'd1;
        c_in <= 0;    

        repeat(10) begin
            @(posedge clk);
            std::randomize(A) with{
                A inside {[-128:127]};
            };
            std::randomize(B) with{
                B inside {[-128:127]};
            };
            std::randomize(c_in);
        end
    end
endmodule

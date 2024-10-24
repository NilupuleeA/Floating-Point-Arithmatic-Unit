`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2024 22:04:54
// Design Name: 
// Module Name: add_24bit_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for 24-bit adder/subtractor.
// 
// Dependencies: add_24bit module.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// module add_24bit_tb();
//     timeunit 1ns;
//     timeprecision 1ps;

//     localparam CLK_PERIOD = 10;
//     logic clk;

//     // Clock generation
//     initial begin
//         clk = 0;
//         forever #(CLK_PERIOD/2) clk = ~clk;
//     end

//     localparam N = 24;
//     logic [N-1:0] A, B, S;
//     logic op, c_out;

//     // Instantiate the 24-bit adder module
//     add_24bit #(.N(N)) dut (.*);

//     initial begin
//     // Initialize values before the first clock edge
//     A = 24'd0;
//     B = 24'd0;
//     op = 1'b0;

//     // Test cases - addition and subtraction
//     @(posedge clk);
//     A = 24'd5;
//     B = 24'd10;
//     op = 1; // Subtract: 5 - 10 = -5 (Two's complement)

//     @(posedge clk);
//     A = 24'd30;
//     B = 24'd10;
//     op = 0; // Add: 30 + 10 = 40

//     @(posedge clk);
//     A = 24'd5;
//     B = 24'd10; 
//     op = 0; // Add: 5 + 10 = 15

//     @(posedge clk);
//     A = 24'd127;
//     B = 24'd1; 
//     op = 1; // Subtract: 127 - 1 = 126

//     // Random test cases
//     repeat(10) begin
//         @(posedge clk);
//         std::randomize(A) with {
//             A inside {[0:16777215]}; // 24-bit unsigned range
//         };
//         std::randomize(B) with {
//             B inside {[0:16777215]};
//         };
//         op = $urandom % 2; // Randomly select addition or subtraction
//     end
// end
// endmodule

module Nbit_adder_tb();
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
    logic c_in, c_out;

    Nbit_adder #(.N(N)) dut (.*);

    initial begin
        A <= 8'd5;
        B <= 8'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 8'd30;
        B <= -8'd10;
        c_in <= 0;

        @(posedge clk);
        A <= 8'd5;
        B <= 8'd10;
        c_in <= 1;  

        @(posedge clk);
        A <= 8'd127;
        B <= -8'd1;
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

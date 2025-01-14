// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 17.10.2024 12:22:21
// // Design Name: 
// // Module Name: fp_div_tb
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////


// module fp_div_tb();
//     localparam CLK_PERIOD = 10;
//     logic clk, rstn;
    
//     initial begin
//         clk = 0;
//         forever #(CLK_PERIOD/2) clk = ~clk; 
//     end

//     logic [31:0] num1;
//     logic [31:0] num2;
//     logic [31:0] S;

//     fp_div dut (.*);

//     initial begin
//         $display("Simulation start");
//         rstn = 1;
//         num2 <= 32'b00111110100111101011100001010010;
//         num1 <= 32'b00111111100011110101110000101001;
//         @(posedge clk);
//         // rstn <=1;

//         repeat (10) 
//         #15 check_output(S, 32'b00111110100011011011011011011011);      
        
//         repeat (60) 
//         @(posedge clk);
//         num2 <= 32'b00111111100011100001010001111011;
//         num1 <= 32'b00111111100000010100011110101110;

//         repeat (10) 
//         #15 check_output(S, 32'b00111111100011001010110001011011);
//           num1 <= 32'b01000000101011100110011001100110; //5.45
//       num2 <= 32'b01000000010011010111000010100100; //3.21


//       @(posedge clk);

//       rstn <= 1;

//       @(posedge clk);
//       rstn <=1;

//       // repeat (10) 
//       #25 
//       check_output(S, 32'b00111111110110010101001000100100);  //1.6978192
// //      check_output(remainder, 24'b101100001100110100000010 );



//       num1 <= 32'b01000010111010100111010111000011;  //117.23
//       num2 <= 32'b01000000101111101011100001010010;  //5.96


//       @(posedge clk);

//       rstn <= 0;

//       @(posedge clk);
//       rstn <=1;

//       // repeat (10) 
//       #15 check_output(S, 32'b01000001100111010101101100010000); 
// //      check_output(remainder, 24'b010010010110001000010010);
//         $display("Simulation end");
//         $finish;
//     end

//      task check_output;
//          input [31:0] actual;
//          input [31:0] expected;
//          if (actual !== expected) begin
//              $display("Test Failed: Expected %h, but got %h", expected, actual);
//          end else begin
//              $display("Test Passed: Output %h matches expected %h", actual, expected);
//          end
//      endtask
// endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 12:22:21
// Design Name: 
// Module Name: fp_div_tb
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


module fp_div_tb();
    localparam CLK_PERIOD = 10;
    logic clk, rstn;
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk; 
    end

    logic [31:0] num1;
    logic [31:0] num2;
    logic valid_out;
    logic [31:0] S;

    fp_div dut (.*);

    initial begin
        $display("Simulation start");
        rstn <= 0;
        num1 <= 32'b00111110100111101011100001010010;
        num2 <= 32'b00111111100011110101110000101001;
        @(posedge clk);
        rstn <=1;

        repeat (10) 
        #15 check_output(S, 32'b00111110100011011011011011011011);      
        
        repeat (60) 
        @(posedge clk);
        num2 <= 32'b00111111100011100001010001111011;
        num1 <= 32'b00111111100000010100011110101110;

        repeat (10) 
        #15 check_output(S, 32'b00111111100011001010110001011011);
        $display("Simulation end");
        $finish;
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



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2024 22:55:14
// Design Name: 
// Module Name: test
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


// module test(
//     input logic clk, rstn,
//     output logic [7:0] result 
//     );

//     logic [3:0] number1, number2;

//     assign number1 = 4'd7;
//     assign number2 = 4'd3;

//     booth_algorithm ba(
//             .clk(clk),
//             .rstn(rstn),            
//             .M(number1),      
//             .Q(number2),      
//             .R(result)    
//         );
// endmodule

module test(
    input logic clk, rstn,
    //input logic [1:0] op,
    output logic [31:0] result 
    );

    logic [31:0] number1, number2;

    assign number1 = 31'b00111111100011100001010001111011;
    assign number2 = 31'b00111111100000010100011110101110;

    fp_mul alu(
        .clk(clk), 
        .rstn(rstn),
        .num1(number1),
        .num2(number2),
        .S(result)
    );
endmodule


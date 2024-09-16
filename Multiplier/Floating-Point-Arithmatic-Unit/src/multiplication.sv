`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2024 10:44:08
// Design Name: 
// Module Name: multiplication
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


module multiplication(
    input logic clk, rstn,
    input logic [23:0] Shifted_val,
    input logic [23:0] nonShifted_val,
    output logic [22:0] fraction,
    input logic [7:0] exponent_temp,
    output logic [7:0] exponent
    );

    logic [47:0] mul;
    logic [4:0] count;

    mult_gen_0 multiply (
        .CLK(clk),  // input wire CLK
        .A(Shifted_val),      // input wire [23 : 0] A
        .B(nonShifted_val),      // input wire [23 : 0] B
        .P(mul)      // output wire [47 : 0] P
    );

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            fraction <= 23'b0;
            count <= '0;
        end else begin
            logic [47:0] temp_mul = mul;
            logic [4:0] temp_count = '0;
            while (!temp_mul[48]) begin
                temp_mul = temp_mul << 1;
                temp_count = temp_count + 1;
            end
            count <= temp_count;
            fraction <= temp_mul[46:24];  
            exponent = exponent_temp + 1 - count;              
        end
    end
endmodule

// module multiplication(
//     input logic clk, rstn,
//     input logic [23:0] Shifted_val,
//     input logic [23:0] nonShifted_val,
//     output logic [47:0] mul
//     );


//     mult_gen_0 multiply (
//         .CLK(clk),  // input wire CLK
//         .A(Shifted_val),      // input wire [23 : 0] A
//         .B(nonShifted_val),      // input wire [23 : 0] B
//         .P(mul)      // output wire [47 : 0] P
//     );


// endmodule

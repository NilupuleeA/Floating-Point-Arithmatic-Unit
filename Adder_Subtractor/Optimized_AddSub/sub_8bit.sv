`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2024 13:35:16
// Design Name: 
// Module Name: sub_8bit
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


module sub_8bit #(
    parameter N = 8
)(
    input logic [N-1:0] A,
    input logic [N-1:0] B,
    output logic [N-1:0] S
);

    logic [N:0] C;
    logic c_in = 1;
    logic c_out;

    assign C[0] = c_in;
    assign S[N] = c_out;

    generate
        for (genvar i = 0; i < N; ++i) begin: add
            full_adder fa(
                .a(A[i]),
                .b(B[i]^c_in),
                .c_in(C[i]),
                .c_out(C[i+1]),
                .sum(S[i])
            );            
        end
    endgenerate
endmodule

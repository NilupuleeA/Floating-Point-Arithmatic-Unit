`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2024 21:07:56
// Design Name: 
// Module Name: add_24bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 24-bit adder/subtractor with a parameterized width and full-adder logic.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// module add_24bit #(
//     parameter N = 24
// )(
//     input logic [N-1:0] A,
//     input logic [N-1:0] B,
//     input logic op,                // Operation: 0 for add, 1 for subtract
//     output logic [N-1:0] S,        // Sum output
//     output logic c_out             // Carry/borrow out
// );

//     logic [N:0] C;                 // Carry chain
//     logic c_in = op;               // Carry in (1 for subtraction)

//     // Initialize the first carry bit with the operation type
//     assign C[0] = c_in;
//     assign c_out = C[N];           // Carry out from the last stage

//     // Full-adder instantiation using generate loop for each bit
//     generate
//         for (genvar i = 0; i < N; ++i) begin: add
//             full_adder fa(
//                 .a(A[i]),
//                 .b(B[i] ^ c_in),   // XOR with c_in for 2's complement subtraction
//                 .c_in(C[i]),
//                 .c_out(C[i+1]),
//                 .sum(S[i])
//             );
//         end
//     endgenerate
// endmodule

module Nbit_adder #(
    parameter N = 8
)(
    input logic [N-1:0] A,
    input logic [N-1:0] B,
    input logic c_in,
    output logic [N-1:0] S,
    output logic c_out
);

    logic [N:0] C;
    assign C[0] = c_in;
    assign c_out = C[N];

    generate
        for (genvar i = 0; i < N; ++i) begin: add
            full_adder fa(
                .a(A[i]),
                .b(B[i]),
                .c_in(C[i]),
                .c_out(C[i+1]),
                .sum(S[i])
            );            
        end
    endgenerate

endmodule

// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 30.09.2024 14:35:01
// // Design Name: 
// // Module Name: unsigned_mul
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


// module unsigned_mul #(
//     parameter N = 3
// )(
//     input logic clk,
//     input logic rstn,            
//     input logic [N-1:0] M,      
//     input logic [N-1:0] Q,      
//     output logic [2*N-1:0] R    
// );

//     logic [2*N+1:0] R_temp;       
//     logic Q0;
//     logic [N:0] A;
//     logic [$clog2(N)-1:0] c_bits;  

//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//             {R, c_bits} <= '0;
//             Q0 <= Q[1];
//             if (Q[0]) begin
//                 R_temp <= { 2'b0, M, Q }; 
//                 A <=  { 2'b0, M[N-1:1] };
//             end else begin
//                 R_temp <= { 2'b0, {N{1'b0}}, Q }; 
//                 A <= '0;
//             end
//         end else begin
//             if (c_bits == N-1) begin
//                 R <= R_temp[2*N:1];              
//             end else if (Q0 == 1) begin
//                 Q0 <= R_temp[2]; 
//                 A <=  A+M >> 1; 
//                 R_temp <= {1'b0, A+M, R_temp[N:1]};  
//                 c_bits <= c_bits + 1;          
//             end else begin
//                 Q0 <= R_temp[2]; 
//                 R_temp <= R_temp >> 1; 
//                 A <= A >> 1;  
//                 c_bits <= c_bits + 1;    
//             end    
//         end
//     end
// endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2024 14:35:01
// Design Name: 
// Module Name: unsigned_mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Unsigned multiplier using a shift-and-add approach
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// module unsigned_mul #(
//     parameter N = 3
// )(
//     input logic clk,
//     input logic rstn,            
//     input logic [N-1:0] M,       // Multiplicand
//     input logic [N-1:0] Q,       // Multiplier
//     output logic [2*N-1:0] R     // Product
// );

//     logic [2*N-1:0] R_temp;     // Temporary register for partial results
//     logic [N-1:0] A;            // Partial sum accumulator
//     logic [N-1:0] temp_M;       // Temporary multiplicand register
//     logic [$clog2(N)-1:0] c_bits;  // Bit counter for the shift-and-add process

//     // Always block to handle multiplication
//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//             // Reset all states when reset is asserted
//             R_temp <= '0;
//             R <= '0;
//             A <= '0;
//             c_bits <= '0;
//         end else if (c_bits == N) begin
//             R <= R_temp;
//         end else begin
//             // Shift-and-add process
//             if (Q[c_bits]) begin
//                 R_temp <= R_temp + (M << c_bits);  // Add shifted multiplicand if current bit of Q is 1
//             end
//             c_bits <= c_bits + 1;
//         end
//     end
// endmodule

module unsigned_mul #(
    parameter N = 3
)(
    input logic [N-1:0] M,       
    input logic [N-1:0] Q,       
    output logic [2*N-1:0] R    
);

    logic [2*N-1:0] temp_product;   
    logic [N-1:0] i;               

    always_comb begin
        temp_product = '0;         
        for (i = 0; i < N; i = i + 1) begin
            if (Q[i]) begin
                temp_product = temp_product + (M << i);  
            end
        end
        
        R = temp_product;  
    end

endmodule
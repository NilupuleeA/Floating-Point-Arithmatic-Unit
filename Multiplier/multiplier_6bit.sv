`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 05:04:21
// Design Name: 
// Module Name: multiplier_6bit
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


// module multiplier_6bit#(
//     parameter N = 6
// )(
//     input logic clk,
//     input logic rstn, 
//     input logic [N-1:0] M,
//     input logic [N-1:0] Q,
//     output logic [2*N-1:0] R
// );

//     logic [4*N-1:0] R_temp; 

//     unsigned_mul mul_1 (
//         .M(M[0 +: N/2]),       
//         .Q(Q[0 +: N/2]),       
//         .clk(clk),            
//         .rstn(rstn),         
//         .R(R_temp[0 +: N])  
//     ); 

//     unsigned_mul mul_2 (
//         .M(M[0 +: N/2]),       
//         .Q(Q[N/2 +: N/2]),      
//         .clk(clk),            
//         .rstn(rstn),         
//         .R(R_temp[N +: N])  
//     ); 

//     unsigned_mul mul_3 (
//         .M(M[N/2 +: N/2]),     
//         .Q(Q[0 +: N/2]),       
//         .clk(clk),            
//         .rstn(rstn),          
//         .R(R_temp[2*N +: N])  
//     ); 

//     unsigned_mul mul_4 (
//         .M(M[N/2 +: N/2]),      
//         .Q(Q[N/2 +: N/2]),      
//         .clk(clk),           
//         .rstn(rstn),          
//         .R(R_temp[3*N +: N])  
//     ); 

//     always_comb begin
//         R[N/2-1:0] = R_temp[N/2-1:0];
//         R[2*N-1:N/2] = R_temp[N-1:N/2] + R_temp[N +: N] + R_temp[2*N +: N];
//         R[2*N-1:N] = R[2*N-1:N] + R_temp[3*N +: N];
//     end

// endmodule

module multiplier_6bit#(
    parameter N = 6
)(
    input logic [N-1:0] M,
    input logic [N-1:0] Q,
    output logic [2*N-1:0] R
);

    logic [4*N-1:0] R_temp; 

    unsigned_mul mul_1 (
        .M(M[0 +: N/2]),       
        .Q(Q[0 +: N/2]),               
        .R(R_temp[0 +: N])  
    ); 

    unsigned_mul mul_2 (
        .M(M[0 +: N/2]),       
        .Q(Q[N/2 +: N/2]),           
        .R(R_temp[N +: N])  
    ); 

    unsigned_mul mul_3 (
        .M(M[N/2 +: N/2]),     
        .Q(Q[0 +: N/2]),               
        .R(R_temp[2*N +: N])  
    ); 

    unsigned_mul mul_4 (
        .M(M[N/2 +: N/2]),      
        .Q(Q[N/2 +: N/2]),               
        .R(R_temp[3*N +: N])  
    ); 

    always_comb begin
        R[N/2-1:0] = R_temp[N/2-1:0];
        R[2*N-1:N/2] = R_temp[N-1:N/2] + R_temp[N +: N] + R_temp[2*N +: N];
        R[2*N-1:N] = R[2*N-1:N] + R_temp[3*N +: N];
    end
endmodule


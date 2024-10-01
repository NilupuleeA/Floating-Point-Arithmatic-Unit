`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 16:59:54
// Design Name: 
// Module Name: optimized_mul
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


module optimized_mul #(
    parameter N = 24
)(
    input logic clk,
    input logic rstn, 
    input logic [N-1:0] M,
    input logic [N-1:0] Q,
    output logic [2*N-1:0] R
);

    logic [4*N-1:0] R_temp; 

    radix_4 mul_1 (
        .M(M[0 +: N/2]),       
        .Q(Q[0 +: N/2]),       
        .clk(clk),            
        .rstn(rstn),         
        .R(R_temp[0 +: N])  
    ); 

    radix_4 mul_2 (
        .M(M[0 +: N/2]),       
        .Q(Q[N/2 +: N/2]),      
        .clk(clk),            
        .rstn(rstn),         
        .R(R_temp[N +: N])  
    ); 

    radix_4 mul_3 (
        .M(M[N/2 +: N/2]),     
        .Q(Q[0 +: N/2]),       
        .clk(clk),            
        .rstn(rstn),          
        .R(R_temp[2*N +: N])  
    ); 

    radix_4 mul_4 (
        .M(M[N/2 +: N/2]),      
        .Q(Q[N/2 +: N/2]),      
        .clk(clk),           
        .rstn(rstn),          
        .R(R_temp[3*N +: N])  
    ); 

    always_comb begin
        R[N/2-1:0] = R_temp[N/2-1:0];
        R[2*N-1:N/2] = R_temp[N-1:N/2] + R_temp[N +: N/2] + R_temp[2*N +: N/2];
        R[2*N-1:N] = R[2*N-1:N] + R_temp[3*N +: N];
    end

endmodule


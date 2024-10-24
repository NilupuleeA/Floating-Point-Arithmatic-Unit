`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2024 21:45:29
// Design Name: 
// Module Name: multiplier_24bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 24-bit multiplier using partial product accumulation.
// 
// Dependencies: unsigned_mul module
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module multiplier_24bit #(
    parameter N = 24
)(
    input logic clk,
    input logic rstn, 
    input logic [N-1:0] M,
    input logic [N-1:0] Q,
    output logic [2*N-1:0] R
);

    logic [4*N-1:0] R_temp; 

    unsigned_mul mul_1 (
        .M(M[0 +: N/2]),       
        .Q(Q[0 +: N/2]),       
        .clk(clk),            
        .rstn(rstn),         
        .R(R_temp[0 +: N])  
    ); 

    unsigned_mul mul_2 (
        .M(M[0 +: N/2]),       
        .Q(Q[N/2 +: N/2]),      
        .clk(clk),            
        .rstn(rstn),         
        .R(R_temp[N +: N])  
    ); 

    unsigned_mul mul_3 (
        .M(M[N/2 +: N/2]),     
        .Q(Q[0 +: N/2]),       
        .clk(clk),            
        .rstn(rstn),          
        .R(R_temp[2*N +: N])  
    ); 

    unsigned_mul mul_4 (
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

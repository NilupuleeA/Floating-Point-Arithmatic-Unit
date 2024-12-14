`timescale 1ns / 1ps

module multiplier_6bit#(
    parameter N = 6
)(
    input logic clk,
    input logic rstn, 
    input logic [N-1:0] M,
    input logic [N-1:0] Q,
    output logic [2*N-1:0] R
);

    logic [4*N-1:0] R_temp; 

    unsigned_mul mul_1 (
        .clk(clk),            
        .rstn(rstn),  
        .M(M[0 +: N/2]),       
        .Q(Q[0 +: N/2]),            
        .R(R_temp[0 +: N])  
    ); 

    unsigned_mul mul_2 (
        .clk(clk),            
        .rstn(rstn),  
        .M(M[0 +: N/2]),       
        .Q(Q[N/2 +: N/2]),      
        .R(R_temp[N +: N])  
    ); 

    unsigned_mul mul_3 (
        .clk(clk),            
        .rstn(rstn),  
        .M(M[N/2 +: N/2]),     
        .Q(Q[0 +: N/2]),       
        .R(R_temp[2*N +: N])  
    ); 

    unsigned_mul mul_4 (
        .clk(clk),            
        .rstn(rstn),  
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




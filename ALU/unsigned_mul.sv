`timescale 1ns / 1ps

module unsigned_mul #(
    parameter N = 3
)(
    input logic clk,
    input logic rstn,            
    input logic [N-1:0] M,       
    input logic [N-1:0] Q,      
    output logic [2*N-1:0] R    
);

    logic [2*N-1:0] A;    
    logic [$clog2(N)-1:0] c_bits; 
    logic [N-1:0] M_prev, Q_prev; 

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            R <= '0;
            A <= '0;
            c_bits <= '0;
            M_prev <= '0;
            Q_prev <= '0;
        end else begin
            if (M != M_prev || Q != Q_prev) begin
                if (c_bits < N) begin
                    if (Q[c_bits]) begin
                        A <= A + (M << c_bits);  
                        c_bits <= c_bits + 1;
                    end else if (!Q[c_bits]) 
                        c_bits <= c_bits + 1;
                end else begin
                    M_prev <= M;
                    Q_prev <= Q;
                    R <= A;  
                    A <= '0;
                    c_bits <= '0;
                end
            end
        end
    end
endmodule


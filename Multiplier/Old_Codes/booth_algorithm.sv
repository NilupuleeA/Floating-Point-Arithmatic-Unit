`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2024 16:51:07
// Design Name: 
// Module Name: booth_algorithm
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


module booth_algorithm #(
    parameter N = 6
)(
    input logic clk,
    input logic rstn,            
    input logic [N-1:0] M,      
    input logic [N-1:0] Q,      
    output logic [2*N-1:0] R    
);

    logic [2*N:0] R_temp;       
    logic Q0, Q_1;
    logic [N-1:0] A;

    enum logic [1:0] {ADD, SUB, SHIFT, END} state;

    logic [$clog2(N)-1:0] c_bits;  

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            // Initialization
            {R, A, Q_1, c_bits} <= '0;
            Q0 <= Q[0];
            if (Q[0]) begin
                state <= SUB;
                R_temp <= { -M, Q, 1'b0 }; 
            end else begin
                state <= SHIFT;
                R_temp <= { {N{1'b0}}, Q, 1'b0 }; 
            end
        end else begin
            case (state)
                ADD: begin   
                    A = A + M;     
                    R_temp = {A, R_temp[N:0]};
                    state <= SHIFT;
                end

                SUB: begin  
                    A = A - M;     
                    R_temp = {A, R_temp[N:0]};
                    state <= SHIFT;
                end

                SHIFT: begin 
                    R_temp = {R_temp[2*N], R_temp[2*N:1]};
                    A = {A[N-1], A[N-1:1]};     
                    c_bits <= c_bits + 1;       
                    Q0 = R_temp[1];
                    Q_1 = R_temp[0]; 
                    

                    if (c_bits == N-1) begin
                        state <= END;   
                    end else if (Q0 == 1 && Q_1 == 0) begin
                        state <= SUB;            
                    end else if (Q0 == 0 && Q_1 == 1) begin
                        state <= ADD;            
                    end else begin
                        state <= SHIFT;    
                    end
                end
                
                END: begin
                    R <= R_temp[2*N:1]; 
                    end
                
            endcase
        end
    end

endmodule


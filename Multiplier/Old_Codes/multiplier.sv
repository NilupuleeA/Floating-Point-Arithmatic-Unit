`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2024 03:11:39
// Design Name: 
// Module Name: multiplier
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

module multiplier #(
    parameter N = 24
)(
    input logic clk,
    input logic rstn,            
    input logic [N-2:0] frac1,      
    input logic [N-2:0] frac2,      
    output logic [2*N-2:0] R    
);

    logic [2*N:0] R_temp;       
    logic Q0, Q_1;
    logic [N-1:0] A;
    logic [N-1:0] M;      
    logic [N-1:0] Q;  

    assign M = {1'b1, frac1};
    assign Q = {1'b1, frac2};

    enum logic [1:0] {ADD, SUB, SHIFT, END} state; // Declare the enum as logic with defined bit size

    logic [$clog2(N)-1:0] c_bits;  // Use $clog2 to calculate the required bits for the counter

    // State machine
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
                    A = A + M;     // Add M to A
                    R_temp = {A, R_temp[N:0]};
                    state <= SHIFT;
                end

                SUB: begin  
                    A = A - M;     // Subtract M from A
                    R_temp = {A, R_temp[N:0]};
                    state <= SHIFT;
                end

                SHIFT: begin 
                    R_temp = {R_temp[2*N], R_temp[2*N:1]};
                    A = {A[N-1], A[N-1:1]};     // Arithmetic right shift A 
                    c_bits <= c_bits + 1;        // Increment counter
                    Q0 = R_temp[1];
                    Q_1 = R_temp[0]; 
                    

                    if (c_bits == N-1) begin
                        state <= END;   // Final result assignment
                    end else if (Q0 == 1 && Q_1 == 0) begin
                        state <= SUB;            // Move to subtraction state
                    end else if (Q0 == 0 && Q_1 == 1) begin
                        state <= ADD;            // Move to addition state
                    end else begin
                        state <= SHIFT;    
                    end
                end
                
                END: begin
                    R <= R_temp[2*N-1:1]; 
                    end
                
            endcase
        end
    end

endmodule


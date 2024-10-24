`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 18:02:25
// Design Name: 
// Module Name: unsigned_div_tb
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

// module unsigned_div #(
//     parameter N = 48
// )(
//     input logic clk,
//     input logic rstn,            
//     input logic [N-1:0] M,      
//     input logic [N-1:0] Q,      
//     output logic [N/2-1:0] Quotient,  
//     output logic [N/2-1:0] Remainder  
// );

//     logic [N-1:0] R_temp;   
//     logic [N-1:0] A, M_copy, Q_copy; 
//     logic [$clog2(N):0] c_bits;  
//     enum logic [2:0] {START, SHIFT, DIVIDE, END} state;

//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//             A <= '0;
//             M_copy <= M;
//             Q_copy <= Q;
//             R_temp <= '0;
//             c_bits <= '0;
//             state <= START;
//             Quotient <= '0;
//             Remainder <= '0;
//         end else begin
//             case (state)
//                 START: begin
//                     R_temp <= Q_copy;  
//                     A <= 0;  
//                     c_bits <= N;  
//                     state <= SHIFT;  
//                 end

//                 SHIFT: begin
//                     if (c_bits == 0) begin
//                         state <= END;  
//                     end else begin
//                         A = {A[N-2:0], R_temp[N-1]}; 
//                         R_temp = {R_temp[N-2:0], 1'b0};  
//                         c_bits <= c_bits - 1;  
//                         state <= DIVIDE;  
//                     end
//                 end

//                 DIVIDE: begin
//                     if (A >= M_copy) begin
//                         A = A - M_copy;  
//                         R_temp[0] = 1'b1;  
//                     end else begin
//                         R_temp[0] = 1'b0;  
//                     end
//                     state <= SHIFT;  
//                 end

//                 END: begin  
//                     Remainder <= A; 
//                     if (A>=M/2) begin
//                         Quotient <= R_temp + 1'b1;
//                     end else begin
//                         Quotient <= R_temp;
//                     end
//                 end

//             endcase
//         end
//     end

// endmodule



// module unsigned_div #(
//     parameter N = 48
// )(
//     input logic clk,
//     input logic rstn,            
//     input logic [N-1:0] M,      
//     input logic [N-1:0] Q,      
//     output logic [N/2-1:0] Quotient,  
//     output logic [N/2-1:0] Remainder  
// );

//     logic [N-1:0] A, M_copy, Q_copy; 
//     logic [N-1:0] R_temp;   
//     logic [$clog2(N):0] c_bits;  
//     enum logic [1:0] {START, PROCESS, END} state;

//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//             A <= '0;
//             M_copy <= M;
//             Q_copy <= Q;
//             R_temp <= '0;
//             c_bits <= N;
//             state <= START;
//             Quotient <= '0;
//             Remainder <= '0;
//         end else begin
//             case (state)
//                 START: begin
//                     R_temp <= Q_copy;  
//                     A <= 0;  
//                     state <= PROCESS;  
//                 end

//                 PROCESS: begin
//                     if (c_bits > 0) begin
//                         // Shift operation
//                         A = {A[N-2:0], R_temp[N-1]}; 
//                         R_temp = {R_temp[N-2:0], 1'b0};  
//                         c_bits <= c_bits - 1;  

//                         // Division operation
//                         if (A >= M_copy) begin
//                             A = A - M_copy;  
//                             R_temp[0] = 1'b1;  
//                         end else begin
//                             R_temp[0] = 1'b0;  
//                         end
//                     end else begin
//                         state <= END;  
//                     end
//                 end

//                 END: begin  
//                     Remainder <= A; 
//                     if (A >= (M_copy >> 1)) begin  // M/2 can be computed using right shift
//                         Quotient <= R_temp + 1'b1;
//                     end else begin
//                         Quotient <= R_temp;
//                     end
//                 end
//             endcase
//         end
//     end

// endmodule 

module unsigned_div #(
    parameter N = 48
)(
    input logic clk,
    input logic rstn,            
    input logic [N-1:0] M,      
    input logic [N-1:0] Q,      
    output logic [N/2-1:0] Quotient,  
    output logic [N/2-1:0] Remainder  
);

    logic [N-1:0] A, M_copy, Q_copy; 
    logic [N-1:0] R_temp;   
    logic [$clog2(N):0] c_bits;  
    enum logic [1:0] {START, PROCESS, END} state;

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            A <= '0;
            M_copy <= M;
            Q_copy <= Q;
            R_temp <= '0;
            c_bits <= N;
            state <= START;
            Quotient <= '0;
            Remainder <= '0;
        end else begin
            // Detect changes in M or Q
            if (M_copy != M || Q_copy != Q) begin
                M_copy <= M;   // Update copies with new values
                Q_copy <= Q;
                state <= START; // Reset state to START if M or Q changes
            end

            case (state)
                START: begin
                    R_temp <= Q_copy;  
                    A <= 0;  
                    c_bits <= N;  // Initialize the bit counter
                    state <= PROCESS;  
                end

                PROCESS: begin
                    if (c_bits > 0) begin
                        // Shift operation
                        A = {A[N-2:0], R_temp[N-1]}; 
                        R_temp = {R_temp[N-2:0], 1'b0};  
                        c_bits <= c_bits - 1;  

                        // Division operation
                        if (A >= M_copy) begin
                            A = A - M_copy;  
                            R_temp[0] = 1'b1;  
                        end else begin
                            R_temp[0] = 1'b0;  
                        end
                    end else begin
                        state <= END;  
                    end
                end

                END: begin  
                    Remainder <= A; 
                    if (A >= (M_copy >> 1)) begin  // M/2 can be computed using right shift
                        Quotient <= R_temp + 1'b1;
                    end else begin
                        Quotient <= R_temp;
                    end
                    state <= START;  // Reset for the next operation
                end
            endcase
        end
    end
endmodule



















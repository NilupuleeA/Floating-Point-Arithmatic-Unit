`timescale 1ns / 1ps

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
            if (M_copy != M || Q_copy != Q) begin
                M_copy <= M;  
                Q_copy <= Q;
                state <= START; 
            end

            case (state)
                START: begin
                    R_temp <= Q_copy;  
                    A <= 0;  
                    c_bits <= N;  
                    state <= PROCESS;  
                end

                PROCESS: begin
                    if (c_bits > 0) begin
                        R_temp <= {R_temp[N-2:0], 1'b0};  
                        c_bits <= c_bits - 1;  

                        if ({A[N-2:0], R_temp[N-1]} >= M_copy) begin
                            A <= {A[N-2:0], R_temp[N-1]} - M_copy;  
                            R_temp[0] <= 1'b1;  
                        end else begin
                            A <= {A[N-2:0], R_temp[N-1]}; 
                            R_temp[0] <= 1'b0;  
                        end
                    end else begin
                        state <= END;  
                    end
                end

                END: begin  
                    Remainder <= A; 
                    if (A >= (M_copy >> 1)) begin 
                        Quotient <= R_temp + 1'b1;
                    end else begin
                        Quotient <= R_temp;
                    end
                    state <= START;  
                end
            endcase
        end
    end
endmodule



















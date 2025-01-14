`timescale 1ns / 1ps

module radix_div #(
    N = 48
)(
    input logic [N-1:0] M, 
    input logic [N-1:0] Q, //divisor
    input logic clk, rstn,
  	output logic [N/2-1:0] quotient,
    output logic [N/2-1:0] remainder,
    output logic normalize,
    output logic valid_out
);
    logic [N:0] R_temp, A;
    logic [N-1:0] M_copy, Q_copy; 
    logic [$clog2(N/2):0] c_bits;
    logic [N-1:0] subt;
    logic overflow;
    enum logic [1:0] {START, SUB, FINAL} state;
    
    
    always_ff @( posedge clk or negedge rstn ) begin : divisor
        if (!rstn) begin
            c_bits <= N/2+1;
            R_temp <= {1'b0, M};
            A <= ~Q + 1;
            {overflow, subt} <= M - Q;
            quotient <= 0; 
            normalize <= 0; 
            state <= START;
            M_copy <= M;  
            Q_copy <= Q;
            valid_out <= 1'b0;
        end

        else begin
            if (M_copy != M || Q_copy != Q) begin
                state <= START; 
            end
            
            case (state)
                START: begin
                    // if (overflow) begin
                    //     state <= SUB;  
                        // normalize <= 1;

                    // end

                    // if (!overflow) begin
                    //     R_temp <= R_temp >> 1;  // can be a edit
                    //     state <= SUB;
                    //     // normalize <= 0;
                    // end
 
                    normalize <= overflow;
                    R_temp <= R_temp >> !overflow;  // can be a edit
                    state <= SUB;
                    valid_out <= 1'b0;
                        // normalize <= 0;
                    end
                    
                // end  

                SUB: begin
                    if (c_bits > 0 && R_temp[N] == 0) begin
                        remainder <= R_temp[N-1:N/2];
                        c_bits <= c_bits - 1;
                        R_temp <= (R_temp << 1) - Q;
                        quotient[c_bits-1] <= 1; 

                    end

                    else if (c_bits > 0 && R_temp[N] == 1) begin
                        remainder <= R_temp[N-1:N/2];
                        c_bits <= c_bits - 1;
                        R_temp <= (R_temp << 1) + Q;
                        quotient[c_bits-1] <= 0; 
                    end

                    else begin
                        state <= FINAL;
                        valid_out <= 1'b1;
                    end    
                end

                FINAL: begin
                    // divisionReady <= 1;
                    c_bits <= N/2+1;
                    R_temp <= {1'b0, M};
                    A <= ~Q + 1;
                    M_copy <= M;  
                    Q_copy <= Q;
                end 
            endcase

        end        
    end
endmodule







// module radix_div #(
//     N = 48
// )(
//     input logic [N-1:0] M, 
//     input logic [N-1:0] Q, //divisor
//     input logic clk, rstn,
//   	output logic [N/2-1:0] quotient,
//     output logic [N/2-1:0] remainder,
//     output logic normalize,
//      output logic valid_out
// );
//     logic [N:0] R_temp, A;
//     logic [N-1:0] M_copy, Q_copy; 
//     logic [$clog2(N/2):0] c_bits;
//     logic [N-1:0] subt;
//     logic overflow;
//     enum logic [1:0] {START, SUB, FINAL} state;
    
    
//     always_ff @( posedge clk or negedge rstn ) begin : divisor
//         if (!rstn) begin
//             c_bits <= N/2+1;
//             R_temp <= {1'b0, M};
//             A <= ~Q + 1;
//             {overflow, subt} <= M - Q;
//             quotient <= 0; 
//             normalize <= 0; 
//             state <= START;
//             M_copy <= M;  
//             Q_copy <= Q;
//             valid_out <= 1'b0;
//         end

//         else begin
//             if (M_copy != M || Q_copy != Q) begin
//                 state <= START; 
//             end
            
//             case (state)
//                 START: begin
//                     normalize <= overflow;
//                     R_temp <= R_temp >> !overflow;  // can be a edit
//                     state <= SUB;
//                     valid_out <= 1'b0;
//                         // normalize <= 0;
//                     end

//                 SUB: begin
//                     if (c_bits > 0 && R_temp[N] == 0) begin
//                         remainder <= R_temp[N-1:N/2];
//                         c_bits <= c_bits - 1;
//                         R_temp <= (R_temp << 1) - Q;
//                         quotient[c_bits-1] <= 1; 

//                     end

//                     else if (c_bits > 0 && R_temp[N] == 1) begin
//                         remainder <= R_temp[N-1:N/2];
//                         c_bits <= c_bits - 1;
//                         R_temp <= (R_temp << 1) + Q;
//                         quotient[c_bits-1] <= 0; 
//                     end

//                     else begin
//                         state <= FINAL;
//                         valid_out <= 1'b1;
//                     end    
//                 end

//                 FINAL: begin
//                     // divisionReady <= 1;
//                     c_bits <= N/2+1;
//                     R_temp <= {1'b0, M};
//                     A <= ~Q + 1;
//                     M_copy <= M;  
//                     Q_copy <= Q;
//                 end 
//             endcase

//         end        
//     end
// endmodule








// module radix4 #(
//     N = 24
//     // N = 8
// ) (
//     input logic [N-1:0] num1, num2,
//     input logic clk,
//     input logic rstn,
//     output logic [2*N-1:0] FinalResult
// );
//     logic [2:0] register;
//     logic [2*N-1:0] multipler, reg1, result, reg2;
//     logic [$clog2(N)-1:0]  c_bits;
//     logic [N:0] num2_dup; 

//     assign result = 0;
    
//     always_ff @( posedge clk or negedge rstn ) begin : State

//         if (!rstn) begin
//             FinalResult <= 0;
//             reg1 <= 0;
//             reg2 <= 0;
//             c_bits <= -1;
//             num2_dup <= {num2, 1'b0}; 

//         end
//         else begin

//             if (c_bits == N/2) begin
//                 FinalResult <= result << 1;

//             end

//             else begin
//                 c_bits <= c_bits + 1;
                
//                 register <= num2_dup[2:0];
//                 num2_dup <= num2_dup >> 2;
//                 reg1  <= result;
//                 reg2 <= multipler << (c_bits)*2;
//             end

            
//         end
//     end

//     always_comb begin : caseHandling

//         case (register)
//             2'b00: q = 0; 
//             2'b01: q = 1; 
//             2'b10: q = -1; 
//             2'b11: q = num1 << 1; 
//             default: q = 0;
//         endcase

//     end
//     // Instantiate the AdderSubtractor_Nbit module
//     AdderSubtractor_Nbit #(2*N) adder_subtractor_instance (
//         .reg1(reg1),         
//         .reg2(reg2),        
//         .op(0),             
//         .result(result),     
//         .cout(cout)   
//     );
    

// endmodule

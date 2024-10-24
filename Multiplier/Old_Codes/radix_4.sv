`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.10.2024 13:55:50
// Design Name: 
// Module Name: radix_4
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


module radix_4 #(
    N = 13
) (
    input logic [N-2:0] M, Q,
    input logic clk,
    input logic rstn,
    output logic [2*N-3:0] R
);
    logic signed [2*N:0] R_temp, A;
    logic [2:0] register;
    logic [$clog2(N)-1:0] c_bits; 
    logic [N-1:0] M_temp, Q_temp;

    assign M_temp = {1'b0, M};  // Add leading 1 to fraction
    assign Q_temp = {1'b0, Q}; 
    
    always_ff @( posedge clk or negedge rstn ) begin 
        if (!rstn) begin
            R_temp <= { 1'b0, {N{1'b0}}, Q_temp }; 
            register <= { Q_temp[1:0], 1'b0 };
            {c_bits, R} <= '0;
        end
        else begin
            if (c_bits == N/2) begin
                R <= R_temp >> 1;
            end else begin
                c_bits <= c_bits + 1;
                register <= R_temp[3:1];
                R_temp <= (A + R_temp) >>> 2;
            end
        end
    end

    always_comb begin
        case (register)
            3'b000: A = 0; 
            3'b001: A = M_temp << N; 
            3'b010: A = M_temp << N; 
            3'b011: A = M_temp << N+1; 
            3'b100: A = (~M_temp + 1'b1) << N+1 ; 
            3'b101: A = (~M_temp + 1'b1) << N; 
            3'b110: A = (~M_temp + 1'b1) << N; 
            3'b111: A = 0;
            default: A = 0;
        endcase
    end
endmodule
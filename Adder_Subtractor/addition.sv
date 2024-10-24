`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 15:43:22
// Design Name: 
// Module Name: addition
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


module addition(
    input logic clk, sel2, rstn,
    input logic [23:0] Shifted_val,
    input logic [23:0] nonShifted_val,
    output logic [22:0] fraction,
    input logic [7:0] exponent_temp,
    output logic [7:0] exponent
    );

    logic [23:0] sum;
    logic c_out;
    logic [4:0] count;

    addsub_24bit add (
        .A(nonShifted_val),          // input wire [23 : 0] A
        .B(Shifted_val),          // input wire [23 : 0] B
        .c_in(sel2),        // input wire CE
        .c_out(c_out),  // output wire C_OUT
        .S(sum)          // output wire [23 : 0] S
    );
    // c_addsub_1 add (
    //     .A(nonShifted_val),          // input wire [23 : 0] A
    //     .B(Shifted_val),          // input wire [23 : 0] B
    //     .CLK(clk),      // input wire CLK
    //     .ADD(sel2 == 0),      // input wire ADD
    //     .CE(1'b1),        // input wire CE
    //     .C_OUT(c_out),  // output wire C_OUT
    //     .S(sum)          // output wire [23 : 0] S
    // );

    // always_ff @(posedge clk or negedge rstn) begin
    //     if (!rstn) begin
    //         fraction <= 23'b0;
    //         count <= '0;
    //     end else begin
    //         if (!sel2 && c_out) begin
    //             fraction <= sum >> 1;
    //             exponent <= exponent_temp + 1;
    //         end else begin
    //             // logic [23:0] temp_sum = sum;
    //             // logic [4:0] temp_count = '0;
    //             // while (!temp_sum[23] && temp_count < 24) begin
    //             //     temp_sum = temp_sum << 1;
    //             //     temp_count = temp_count + 1;
    //             // end
    //             logic [23:0] temp_sum;
    //             logic [4:0] temp_count;
    //             temp_sum = sum;
    //             temp_count = 0;
            
    //             // Use a for loop with a fixed iteration limit
    //             for (int i = 0; i < 24; i++) begin
    //                 if (!temp_sum[23]) begin
    //                     temp_sum = temp_sum << 1;
    //                     temp_count = temp_count + 1;
    //                 end else begin
    //                     break;
    //                 end
    //             end
    //             count <= temp_count;
    //             fraction <= temp_sum;  
    //             exponent = exponent_temp - count;              
    //         end
    //     end
    // end

    always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        fraction <= 23'b0;
        count <= '0;
    end else begin
        if (!sel2 && c_out) begin
            fraction <= sum >> 1;
            exponent <= exponent_temp + 1;
        end else begin
            logic [23:0] temp_sum;
            logic [4:0] temp_count;
            temp_sum = sum;
            temp_count = 0;
            
            // Find the highest bit set in sum
            // This can be optimized to parallel or pipelined logic if needed
            while (!temp_sum[23] && temp_count < 24) begin
                temp_sum = temp_sum << 1;
                temp_count = temp_count + 1;
            end
            
            // Register the results
            count <= temp_count;
            fraction <= temp_sum;  
            exponent = exponent_temp - count;               
            end
        end
    end
endmodule

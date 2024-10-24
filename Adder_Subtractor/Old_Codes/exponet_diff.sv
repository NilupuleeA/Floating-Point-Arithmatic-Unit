`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 13:34:10
// Design Name: 
// Module Name: exponet_diff
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


module exponet_diff(
    input logic clk,
    input logic [7:0] expo1,
    input logic [7:0] expo2,
    input logic [22:0] frac1,
    input logic [22:0] frac2,
    output logic [7:0] exp_diff,
    output logic sel
    );

    logic [7:0] exp_temp;

    c_addsub_0 sub (
        .A(expo1),      // input wire [7 : 0] A
        .B(expo2),      // input wire [7 : 0] B
        .CLK(clk),  // input wire CLK
        .CE(1'b1),    // input wire CE
        .S(exp_temp)      // output wire [7 : 0] S
    );

    always_comb begin
        if (expo1 == expo2) begin
            if (frac1 >= frac2)
                sel = 1;
            else 
                sel = 0;
            exp_diff = exp_temp;
        end else if (!exp_temp[7]) begin
            sel = 1;
            exp_diff = exp_temp;
        end else begin
            sel = 0;
            exp_diff = -8'd255 + exp_temp + 1'b1;
        end
    end

endmodule

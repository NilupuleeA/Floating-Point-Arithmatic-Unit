`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2024 23:49:15
// Design Name: 
// Module Name: sign
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


module sign(
    input logic clk, rstn, sel,
    input logic sign1, sign2,
    output logic sel2, sign
    );

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            sel2 <= 0;
            sign <= 0;
        end else begin
            if (!(sign1 ^ sign2)) begin
                sel2 <= 0;
                sign <= sign1;
            end else begin
                sel2 <= 1;
                if (sel) //2nd number
                    sign <= sign1;
                else  //first number
                    sign <= sign2;    
            end
        end
    end
endmodule


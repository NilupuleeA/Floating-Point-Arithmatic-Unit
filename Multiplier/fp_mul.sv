`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2024 17:08:31
// Design Name: 
// Module Name: fp_mul
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


// module fp_mul(
//     input logic clk, rstn,
//     input logic [31:0] num1,
//     input logic [31:0] num2,
//     output logic [31:0] S 
// ); 
//     logic sign1, sign2, sign;
//     logic [23:0] frac1, frac2; 
//     logic [7:0] expo1, expo2, exp_temp, exp_add;
//     logic [22:0] fraction;
//     logic [7:0] exponent;
//     logic [47:0] result;
//     logic c_out;
//     logic [4:0] count;

//     assign sign1 = num1[31];
//     assign sign2 = num2[31];
//     assign frac1 = {1'b1, num1[22:0]};
//     assign frac2 = {1'b1, num2[22:0]};
//     assign expo1 = num1[30:23];
//     assign expo2 = num2[30:23];

//     multiplier_24bit fac (
//         .clk(clk),
//         .rstn(rstn),            
//         .M(frac1),      
//         .Q(frac2),      
//         .R(result)
//     );

//     add_8bit add (
//         .A(expo1),      
//         .B(expo2),      
//         .S(exp_add)     
//     );

//     sub_8bit sub (
//         .A(exp_add),      
//         .B(8'd127),      
//         .S(exp_temp)      
//     );

//     assign sign = sign1^sign2;

//     always_comb begin
//         if(!result[47]) begin
//             fraction = result[45:23] + result[22];
//             exponent = exp_temp;
//         end else begin
//             fraction = result[46:22] + result[21];
//             exponent = exp_temp+1;
//         end
//     end

//     assign S[31] = sign;
//     assign S[30:23] = exponent;
//     assign S[22:0] = fraction;
// endmodule


module fp_mul(
    input logic clk, rstn,
    input logic [31:0] num1,
    input logic [31:0] num2,
    output logic [31:0] S
); 
    logic sign1, sign2, sign;
    logic [23:0] frac1, frac2; 
    logic [7:0] expo1, expo2, exp_temp, exp_add;
    logic [22:0] fraction;
    logic [7:0] exponent;
    logic [47:0] result;
    logic [4:0] count;

    // Assigning sign, fraction (mantissa), and exponent from inputs
    assign sign1 = num1[31];
    assign sign2 = num2[31];
    assign frac1 = {1'b1, num1[22:0]};  // Implicit leading 1
    assign frac2 = {1'b1, num2[22:0]};
    assign expo1 = num1[30:23];
    assign expo2 = num2[30:23];

    // Instantiate the 24-bit multiplier
    multiplier_24bit fac (          
        .M(frac1),      
        .Q(frac2),      
        .R(result)
    );

    // Add the exponents
    add_8bit add (
        .A(expo1),      
        .B(expo2),      
        .S(exp_add)     
    );

    // Subtract the bias (127) from the exponent sum
    sub_8bit sub (
        .A(exp_add),      
        .B(8'd127),      
        .S(exp_temp)      
    );

    // XOR the signs to determine the output sign
    assign sign = sign1 ^ sign2;

    // Always block for sequential logic
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            S <= 32'b0;  // Reset S to 0
        end else begin
            // Check if result[47] is 0 for normalization
            if (!result[47]) begin
                fraction <= result[45:23] + result[22];  // Normalized result
                exponent <= exp_temp;
            end else begin
                fraction <= result[46:22] + result[21];  // Shift and normalize
                exponent <= exp_temp + 1;
            end

            // Construct final output
            S[31] <= sign;           // Assign the sign
            S[30:23] <= exponent;    // Assign the exponent
            S[22:0] <= fraction;     // Assign the mantissa
        end
    end
endmodule

// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 15.07.2024 14:16:53
// // Design Name: 
// // Module Name: fraction
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////


// module fraction(
//     input logic clk, rstn,
//     input logic [22:0] frac1,
//     input logic [22:0] frac2,
//     output logic [23:0] Shifted_val,
//     output logic [23:0] nonShifted_val,
//     input logic [7:0] exp_diff,
//     input logic sel,
//     input logic [7:0] expo1, expo2,
//     output logic [7:0] exponent_temp
//     );

//     logic [23:0] val1, val2;

//     assign val1[23] = 1'b1;
//     assign val2[23] = 1'b1;

//     generate
//         for (genvar i = 0; i < 23; ++i) begin: shift
//             assign val1[i] = frac1[i];
//             assign val2[i] = frac2[i];
//         end
//     endgenerate

//     // always_ff @(posedge clk or negedge rstn) begin
//     //     if (!rstn) begin
//     //         Shifted_val <= '0;
//     //         nonShifted_val <= '0;
//     //         exponent_temp <= '0;
            
//     //     end else begin
//     //         // Intermediate signals to hold values for one clock cycle
//     //         logic [23:0] next_Shifted_val;
//     //         logic [23:0] next_nonShifted_val;
//     //         logic [7:0] next_exponent;
                
//     //         if (sel) begin
//     //             next_Shifted_val = val2 >> exp_diff;
//     //             next_nonShifted_val = val1;
//     //             next_exponent = expo1;
//     //         end else begin
//     //             next_Shifted_val = val1 >> exp_diff;
//     //             next_nonShifted_val = val2;
//     //             next_exponent = expo2;
//     //         end

//     //     // Assign values from intermediate signals to outputs
//     //     Shifted_val <= next_Shifted_val;
//     //     nonShifted_val <= next_nonShifted_val;
//     //     exponent_temp <= next_exponent;
//     // end
//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
//             Shifted_val <= '0;
//             nonShifted_val <= '0;
//             exponent_temp <= '0;
            
//         end else begin
//             // Directly update outputs in one cycle based on `sel` signal
//             if (sel) begin
//                 Shifted_val <= val2 >> exp_diff;
//                 nonShifted_val <= val1;
//                 exponent_temp <= expo1;
//             end else begin
//                 Shifted_val <= val1 >> exp_diff;
//                 nonShifted_val <= val2;
//                 exponent_temp <= expo2;
//             end
//         end
//     end


// endmodule


// `timescale 1ns / 1ps

// module fraction(
//     input logic clk, rstn,
//     input logic [22:0] frac1,
//     input logic [22:0] frac2,
//     output logic [23:0] Shifted_val,
//     output logic [23:0] nonShifted_val,
//     input logic [7:0] exp_diff,
//     input logic sel,
//     input logic [7:0] expo1, expo2,
//     output logic [7:0] exponent_temp
//     );

//     logic [23:0] val1, val2;

//     assign val1 = {1'b1, frac1};  // Add leading 1
//     assign val2 = {1'b1, frac2};  // Add leading 1

//     always_comb begin
//         if (sel) begin
//             Shifted_val = val2 >> exp_diff;
//             nonShifted_val = val1;
//             exponent_temp = expo1;
//         end else begin
//             Shifted_val = val1 >> exp_diff;
//             nonShifted_val = val2;
//             exponent_temp = expo2;
//         end
//     end

// endmodule


// `timescale 1ns / 1ps

// module fraction(
//     input logic clk, rstn,
//     input logic [22:0] frac1,
//     input logic [22:0] frac2,
//     input logic [7:0] expo1, expo2,
//     output logic [23:0] Shifted_val,
//     output logic [23:0] nonShifted_val,
//     output logic [7:0] exponent_temp,
//     output logic sel
//     );

//     logic [23:0] val1, val2;
//     logic [7:0] exp_diff;

//     assign val1 = {1'b1, frac1};  // Add leading 1
//     assign val2 = {1'b1, frac2};  // Add leading 1

//     c_addsub_0 sub (
//         .A(expo1),      // input wire [7 : 0] A
//         .B(expo2),      // input wire [7 : 0] B
//         .CLK(clk),  // input wire CLK
//         .CE(1'b1),    // input wire CE
//         .S(exp_diff)      // output wire [7 : 0] S
//     );

//     always_comb begin
//         if (expo1 == expo2) begin
//             if (frac1 >= frac2)
//                 sel = 1;
//             else 
//                 sel = 0;
//         end else if (!exp_diff[7]) begin
//             sel = 1;
//             Shifted_val = val2 >> exp_diff;
//             nonShifted_val = val1;
//             exponent_temp = expo1;
//         end else begin
//             sel = 0;
//             Shifted_val = val1 >> -exp_diff;
//             nonShifted_val = val2;
//             exponent_temp = expo2;
//         end
//     end
// endmodule

`timescale 1ns / 1ps

module fraction(
    input logic clk, rstn,
    input logic [22:0] frac1,
    input logic [22:0] frac2,
    input logic [7:0] expo1, expo2,
    output logic [23:0] Shifted_val,
    output logic [23:0] nonShifted_val,
    output logic [7:0] exponent_temp,
    output logic sel
    );

    logic [23:0] val1, val2;
    logic signed [7:0] exp_diff;  // Signed to handle negative differences

    assign val1 = {1'b1, frac1};  // Add leading 1 to fraction
    assign val2 = {1'b1, frac2};  // Add leading 1 to fraction

    // Calculate exponent difference combinationally
    //assign exp_diff = expo1 - expo2;

    sub_8bit sub (
        .A(expo1),      // input wire [7 : 0] A
        .B(expo2),      // input wire [7 : 0] B
        .S(exp_diff)      // output wire [7 : 0] S
    );

    always_comb begin
        if (expo1 == expo2) begin
            // If exponents are equal, choose based on fraction comparison
            if (frac1 >= frac2) begin
                sel = 1;
                Shifted_val = val2;  // No shift needed, values are equal
                nonShifted_val = val1;
                exponent_temp = expo1;  // Equal exponents
            end else begin
                sel = 0;
                Shifted_val = val1;
                nonShifted_val = val2;
                exponent_temp = expo2;
            end
        end else if (exp_diff >= 0) begin
            // expo1 > expo2, so shift frac2
            sel = 1;
            Shifted_val = val2 >> exp_diff;
            nonShifted_val = val1;
            exponent_temp = expo1;  // Keep the larger exponent
        end else begin
            // expo2 > expo1, so shift frac1
            sel = 0;
            Shifted_val = val1 >> -exp_diff;  // Shift in the opposite direction
            nonShifted_val = val2;
            exponent_temp = expo2;  // Keep the larger exponent
        end
    end

endmodule

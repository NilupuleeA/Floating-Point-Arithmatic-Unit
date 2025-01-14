// // `timescale 1ns / 1ps

// // module fp_div(
// //     input logic clk, rstn,
// //     input logic [31:0] num1,
// //     input logic [31:0] num2,
// //     output logic [31:0] S 
// // ); 
// //     logic sign1, sign2, sign;
// //     logic [47:0] frac1, frac2; 
// //     logic [7:0] expo1, expo2, exp_temp, exp_sub;
// //     logic [22:0] fraction;
// //     logic [7:0] exponent;
// //     logic [23:0] result;
// //     logic c_out;
// //     logic [4:0] count;

// //     assign sign1 = num1[31];
// //     assign sign2 = num2[31];
// //     assign frac1 = {24'b0, 1'b1, num1[22:0]};
// //     assign frac2 = {1'b1, num2[22:0], 24'b0};
// //     assign expo1 = num1[30:23];
// //     assign expo2 = num2[30:23];

// //     unsigned_div fac (
// //         .clk(clk),
// //         .rstn(rstn),            
// //         .M(frac1),      
// //         .Q(frac2),      
// //         .Quotient(result)
// //     );

// //     sub_8bit sub (
// //         .A(expo2),      
// //         .B(expo1),      
// //         .S(exp_sub)     
// //     );

// //     add_8bit add (
// //         .A(exp_sub),      
// //         .B(8'd127),      
// //         .S(exp_temp)      
// //     );

// //     assign sign = sign1^sign2;

// //     always_comb begin
// //         if(result[23]) begin
// //             fraction = result;
// //             exponent = exp_temp-1;
// //         end else begin
// //             fraction = result >> 1;
// //             exponent = exp_temp;
// //         end
// //     end

// //     assign S[31] = sign;
// //     assign S[30:23] = exponent;
// //     assign S[22:0] = fraction;
// // endmodule


// `timescale 1ns / 1ps

// module fp_div(
//     input logic clk, rstn,
//     input logic [31:0] num1,
//     input logic [31:0] num2,
//     output logic [31:0] S
// ); 
//     logic sign1, sign2, normalize;
//     logic [47:0] frac1, frac2; 
//     logic [7:0] expo1, expo2, exp_temp, exp_sub;
//     logic [22:0] fraction;
//     logic [7:0] exponent;
//     logic [23:0] result;
//     logic c_out;
//     logic [4:0] count;

//     assign sign1 = num1[31];
//     assign sign2 = num2[31];
//     assign frac1 = {24'b0, 1'b1, num1[22:0]};
//     assign frac2 = {1'b1, num2[22:0], 24'b0};
//     assign expo1 = num1[30:23];
//     assign expo2 = num2[30:23];

//     radix_div fac (
//         .clk(clk),
//         .rstn(rstn),            
//         .M(frac1),      
//         .Q(frac2),      
//         .quotient(result),
//         .normalize(normalize)
//     );

//     sub_8bit sub (
//         .A(expo1),      
//         .B(expo2),      
//         .S(exp_sub)     
//     );

//     add_8bit add (
//         .A(exp_sub),      
//         .B(8'd127),      
//         .S(exp_temp)      
//     );

//     always_comb begin
//         S[31] = sign1^sign2;
//         if(normalize) begin
//             S[22:0] = result;
//             S[30:23] = exp_temp-1;
//         end else begin
//             S[22:0] = result;
//             S[30:23] = exp_temp;
//         end
//     end

// endmodule




// `timescale 1ns / 1ps

// module fp_div(
//     input logic clk, rstn,
//     input logic [31:0] num1,
//     input logic [31:0] num2,
//     output logic [31:0] S 
// ); 
//     logic sign1, sign2, sign;
//     logic [47:0] frac1, frac2; 
//     logic [7:0] expo1, expo2, exp_temp, exp_sub;
//     logic [22:0] fraction;
//     logic [7:0] exponent;
//     logic [23:0] result;
//     logic c_out;
//     logic [4:0] count;

//     assign sign1 = num1[31];
//     assign sign2 = num2[31];
//     assign frac1 = {1'b1, num1[22:0], 24'b0};
//     assign frac2 = {1'b1, num2[22:0], 24'b0};
//     assign expo1 = num1[30:23];
//     assign expo2 = num2[30:23];

//     radix_div fac (
//         .clk(clk),
//         .rstn(rstn),            
//         .M(frac1),      
//         .Q(frac2),      
//         .quotient(result)
//     );

//     sub_8bit sub (
//         .A(expo2),      
//         .B(expo1),      
//         .S(exp_sub)     
//     );

//     add_8bit add (
//         .A(exp_sub),      
//         .B(8'd127),      
//         .S(exp_temp)      
//     );

//     assign sign = sign1^sign2;

//     always_comb begin
//         if(result[23]) begin
//             fraction = result;
//             exponent = exp_temp-1;
//         end else begin
//             fraction = result >> 1;
//             exponent = exp_temp;
//         end
//     end

//     assign S[31] = sign;
//     assign S[30:23] = exponent;
//     assign S[22:0] = fraction;
// endmodule




`timescale 1ns / 1ps

module fp_div(
    input logic clk, rstn,
    input logic [31:0] num1,
    input logic [31:0] num2,
    output logic valid_out,
    output logic [31:0] S 
); 
    logic sign1, sign2;
    logic [47:0] frac1, frac2; 
    logic [7:0] expo1, expo2, exp_temp, exp_sub;
    logic [22:0] fraction;
    logic [23:0] result;
    logic c_out;
    logic [4:0] count;

    assign sign1 = num1[31];
    assign sign2 = num2[31];
    assign frac1 = {1'b1, num1[22:0], 24'b0};
    assign frac2 = {1'b1, num2[22:0], 24'b0};
    assign expo1 = num1[30:23];
    assign expo2 = num2[30:23];

    radix_div fac (
        .clk(clk),
        .rstn(rstn),            
        .M(frac1),      
        .Q(frac2),   
        .normalize(normalize),
        .valid_out(valid_out),   
        .quotient(result)
    );

    sub_8bit sub (
        .A(expo1),      
        .B(expo2),      
        .S(exp_sub)     
    );

    add_8bit add (
        .A(exp_sub),      
        .B(8'd127),      
        .S(exp_temp)      
    );

    // always_comb begin
    //     S[31] <= sign1^sign2;
    //     if (normalize) begin
    //         if(result[23]) begin
    //             S[30:23] <= exp_temp;
    //             S[22:0] <= result;     
    //         end  else begin
    //             S[22:0] <= result >> 1;
    //             S[30:23] <= exp_temp;       
    //         end
    //     end
    //     else begin
    //         if(result[23]) begin
    //             S[30:23] <= exp_temp+ 1'b1; 
    //             S[22:0] <= result;     
    //         end  else begin
    //             S[22:0] <= result >> 1;
    //             S[30:23] <= exp_temp;       
    //         end   
    //     end
    // end

    always_comb begin
        S[31] <= sign1^sign2;
        if (normalize) begin
            S[30:23] <= exp_temp - 1;
            S[22:0] <= result;     
        end
        else begin
            S[30:23] <= exp_temp; 
            S[22:0] <= result;     
        end
    end

    // always_ff @( posedge clk or negedge rstn ) begin : divider
    //     if (!rstn) begin
    //     result <= 32'b0;
    //     end
    //     else begin
    //         S[31] <= sign1^sign2;
    //         if (normalize) begin
    //             S[30:23] <= exp_temp + 1'b1;
    //             S[22:0] <= result;
    //             if(result[23]) begin
    //                 S[30:23] <= exp_temp;
    //                 S[22:0] <= result;     
    //             end  else begin
    //                 S[22:0] <= result >> 1;
    //                 S[30:23] <= exp_temp + 1'b1;       
    //             end
    //         end
    //         else begin
    //             if(result[23]) begin
    //                 S[30:23] <= exp_temp;
    //                 S[22:0] <= result;     
    //             end  else begin
    //                 S[22:0] <= result >> 1;
    //                 S[30:23] <= exp_temp + 1'b1;       
    //             end                
    //         end
    //     end
    // end
endmodule


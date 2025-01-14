 `timescale 1ns / 1ps

 module test(
    input logic clk, rstn,
    input logic [1:0] op,
    output logic [6:0] seg_out1, seg_out2, seg_out3, seg_out4, seg_out5, seg_out6, seg_out7, seg_out8 
    );

    logic [31:0] number1, number2, result;

    assign number1 = 31'b00111111100011100001010001111011;
    assign number2 = 31'b00111111100000010100011110101110;

    fp_alu alu(
        .clk(clk), 
        .rstn(rstn),
        .num1(number1),
        .num2(number2),
        .op(op),  // 2-bit input operation code
        .S(result)
    );

    seven_segment_display segA (
        .num(result[3 : 0]),  
        .seg(seg_out1)              
    );
    seven_segment_display segB (
        .num(result[7 : 4]),  
        .seg(seg_out2)              
    );
    seven_segment_display segC (
        .num(result[11 : 8]),  
        .seg(seg_out3)              
    );
    seven_segment_display segD (
        .num(result[15 : 12]),  
        .seg(seg_out4)              
    );
    seven_segment_display segE (
        .num(result[19 : 16]),  
        .seg(seg_out5)              
    );
    seven_segment_display segF (
        .num(result[23 : 20]),  
        .seg(seg_out6)              
    );
    seven_segment_display segG (
        .num(result[27 : 24]),  
        .seg(seg_out7)              
    );
    seven_segment_display segH (
        .num(result[31 : 28]),  
        .seg(seg_out8)              
    );
 endmodule




//`timescale 1ns / 1ps

//module test(
//    input logic clk, rstn,
//    // input logic [1:0] op,
//    output logic [31:0] result 
//    );

//    logic [31:0] number1, number2;
//    logic [1:0] op;

//    assign number1 = 31'b00111111100011100001010001111011;
//    assign number2 = 31'b00111111100000010100011110101110;
//    assign op = 2'b00;

//    fp_alu alu(
//        .clk(clk), 
//        .rstn(rstn),
//        .num1(number1),
//        .num2(number2),
//        .op(op),  // 2-bit input operation code
//        .S(result)
//    );
//endmodule




//  `timescale 1ns / 1ps

//  module test(
//     input logic clk, rstn,
//     input logic [1:0] op,
//     output logic [6:0] seg_out
//     );

//     logic [31:0] number1, number2, result;

//     assign number1 = 31'b00111111100011100001010001111011;
//     assign number2 = 31'b00111111100000010100011110101110;

//     fp_alu alu(
//         .clk(clk), 
//         .rstn(rstn),
//         .num1(number1),
//         .num2(number2),
//         .op(op),  // 2-bit input operation code
//         .S(result)
//     );

//     typedef enum logic [3:0] {
//         S1, S2, S3, S4, 
//         S5, S6, S7, S8
//     } state_t;

//     state_t state;

//     logic [31:0] count;

//     always_ff @(posedge clk or negedge rstn) begin
//         if (!rstn) begin
// //            {S1, S2, S3, S4, S5, S6, S7, S8} <= '0;
//             state <= S1;
//             count <= 0;
//         end else begin
//             case(state)
//                 S1: begin
//                     if (count[31]) begin
//                         state <= S2;
//                         count <= 0;
//                     end else begin
//                         count <= count + 1;
//                     end
//                     seven_segment_display segA (
//                         .num(result[3 : 0]),  
//                         .seg(seg_out)              
//                     );
//                 end

//                 S2: begin
//                     if (count[31]) begin
//                         state <= S3;
//                         count <= 0;
//                     end else begin
//                         count <= count + 1;
//                     end
//                     seven_segment_display segA (
//                         .num(result[7 : 4]),  
//                         .seg(seg_out)              
//                     );
//                 end

//                 S3: begin
//                     if (count[31]) begin
//                         state <= S4;
//                         count <= 0;
//                     end else begin
//                         count <= count + 1;
//                     end
//                     seven_segment_display segA (
//                         .num(result[11 : 8]),  
//                         .seg(seg_out)              
//                     );
//                 end

//                 S4: begin
//                     if (count[31]) begin
//                         state <= S5;
//                         count <= 0;
//                     end else begin
//                         count <= count + 1;
//                     end
//                     seven_segment_display segA (
//                         .num(result[15 : 12]),  
//                         .seg(seg_out)              
//                     );
//                 end

//                 S5: begin
//                     if (count[31]) begin
//                         state <= S6;
//                         count <= 0;
//                     end else begin
//                         count <= count + 1;
//                     end
//                     seven_segment_display segA (
//                         .num(result[19 : 16]),  
//                         .seg(seg_out)              
//                     );
//                 end

//                 S6: begin
//                     if (count[31]) begin
//                         state <= S7;
//                         count <= 0;
//                     end else begin
//                         count <= count + 1;
//                     end
//                     seven_segment_display segA (
//                         .num(result[23 : 20]),  
//                         .seg(seg_out)              
//                     );
//                 end

//                 S7: begin
//                     if (count[31]) begin
//                         state <= S8;
//                         count <= 0;
//                     end else begin
//                         count <= count + 1;
//                     end
//                     seven_segment_display segA (
//                         .num(result[27 : 24]),  
//                         .seg(seg_out)              
//                     );
//                 end

//                 S8: begin
//                     seven_segment_display segA (
//                         .num(result[31 : 28]),  
//                         .seg(seg_out)              
//                     );
//                 end
//             endcase
//         end
//     end
// endmodule
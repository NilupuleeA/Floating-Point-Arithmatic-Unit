`timescale 1ns / 1ps

module fp_add_sub(
    input logic clk, rstn,
    input logic [31:0] num1,
    input logic [31:0] num2,
    input logic [1:0] op,
    output logic [31:0] S 
); 
    logic sign1, sign2, sign;
    logic [22:0] frac1, frac2; 
    logic [7:0] expo1, expo2, exp_diff;
    logic [7:0] exponent_temp;
    logic sel, sel2;
    logic [23:0] Shifted_val, nonShifted_val;
    logic [22:0] fraction;
    logic [7:0] exponent;

    logic [23:0] val1, val2;
    logic [23:0] sum;
    logic [23:0] temp_sum;
    logic c_out;
    logic [4:0] count;

    assign val1 = {1'b1, frac1};  
    assign val2 = {1'b1, frac2};  

    assign sign1 = num1[31];
    assign sign2 = num2[31];
    assign frac1 = num1[22:0];
    assign frac2 = num2[22:0];
    assign expo1 = num1[30:23];
    assign expo2 = num2[30:23];

    fraction fac (
        .clk(clk), 
        .rstn(rstn),
        .frac1(frac1),
        .frac2(frac2),
        .sel(sel),
        .expo1(expo1), 
        .expo2(expo2),
        .exponent_temp(exponent_temp),
        .Shifted_val(Shifted_val),
        .nonShifted_val(nonShifted_val)
    );

    addsub_24bit add (
        .A(nonShifted_val),       
        .B(Shifted_val),          
        .c_in(sel2),      
        .c_out(c_out),  
        .S(sum)          
    );

    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            fraction <= 23'b0;
            count <= '0;
            exponent <= '0;
            temp_sum <= '0;
        end else begin
            if (!sel2 && c_out) begin
                fraction <= sum >> 1;
                exponent <= exponent_temp + 1;
            end else begin      
                temp_sum <= sum;
                while (!sum[23] && count < 24) begin
                    temp_sum <= temp_sum << 1;
                    count <= count + 1;
                end
                fraction <= temp_sum;  
                exponent <= exponent_temp - count;               
            end
        end
    end
    
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            sel2 <= 0;
            sign <= 0;
        end else if (!op) begin
            if (!(sign1 ^ sign2)) begin
                sel2 <= 0;
                sign <= sign1;
            end else begin
                sel2 <= 1;
                if (sel)
                    sign <= sign1;
                else  
                    sign <= sign2;    
            end
        end else if (op) begin
            if (!(sign1 ^ sign2)) begin
                sel2 <= 1;
                if (sel) 
                    sign <= sign1;
                else 
                    sign <= !sign2;    
            end else begin
                sel2 <= 0;  
                if (sel) 
                    sign <= sign1;
                else 
                    sign <= !sign2; 
            end                        
        end
    end

    assign S[31] = sign;
    assign S[30:23] = exponent;
    assign S[22:0] = fraction;
endmodule


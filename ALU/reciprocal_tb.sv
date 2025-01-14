`timescale 1ns / 1ps

module reciprocal_tb;

    reg [31:0] fp_in;
    reg clk;
    wire [31:0] fp_out;

    // Instantiate the reciprocal module
    reciprocal uut (
        .fp_in(fp_in),
        .fp_out(fp_out)
    );

    // Task to display the input and output in a readable format
    task display_result;
        input [31:0] input_fp;
        input [31:0] output_fp;
        begin
            $display("Input FP: %b (sign: %b, exponent: %h, mantissa: %h)\nOutput FP: %b (sign: %b, exponent: %h, mantissa: %h)\n",
                     input_fp, input_fp[31], input_fp[30:23], input_fp[22:0],
                     output_fp, output_fp[31], output_fp[30:23], output_fp[22:0]);
        end
    endtask

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    initial begin
        // Test Case 1: Zero (should output positive infinity)
        @(posedge clk) fp_in = 32'b0_00000000_00000000000000000000000;
        @(posedge clk) display_result(fp_in, fp_out);

        // // Test Case 2: Positive infinity (should output infinity)
        // @(posedge clk) fp_in = 32'b0_11111111_00000000000000000000000;
        // @(posedge clk) display_result(fp_in, fp_out);

        // // Test Case 3: NaN (should output NaN)
        // @(posedge clk) fp_in = 32'b0_11111111_10000000000000000000000;
        // @(posedge clk) display_result(fp_in, fp_out);

        // // Test Case 4: Normalized number (positive, e.g., 1.5)
        // @(posedge clk) fp_in = 32'b0_01111111_10000000000000000000000; // 1.5
        // @(posedge clk) display_result(fp_in, fp_out);

        // // Test Case 5: Normalized number (negative, e.g., -2.0)
        // @(posedge clk) fp_in = 32'b1_10000000_00000000000000000000000; // -2.0
        // @(posedge clk) display_result(fp_in, fp_out);

        // // Test Case 6: Denormalized number (small positive number)
        // @(posedge clk) fp_in = 32'b0_00000000_00000000000000000000001; // Smallest positive denorm
        // @(posedge clk) display_result(fp_in, fp_out);

        // // Test Case 7: Arbitrary normalized number
        // @(posedge clk) fp_in = 32'b0_10000001_01000000000000000000000; // Example: 5.0
        // @(posedge clk) display_result(fp_in, fp_out);

        $stop;
    end

endmodule

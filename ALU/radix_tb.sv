module tb_radix_div;

    // Parameters
    parameter N = 8;
    
    // Testbench signals
    logic [N-1:0] num1, num2;
    logic clk, rstn;
    logic [N:0] quotient, remainder;
    logic normalize, divisionReady;
    
    // Instantiate the radix_div module
    radix_div #(
        .N(N)
    ) uut (
        .M(num1),
        .Q(num2),
        .clk(clk),
        .rstn(rstn),
        .quotient(quotient),
        .remainder(remainder),
        .normalize(normalize)
        // .divisionReady(divisionReady)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 100 MHz clock
    end
    
    // Initial block for stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rstn = 0;
        num1 = 0;
        num2 = 0;
        
        // Apply reset
        #10 rstn = 1;
        @(posedge clk);
        // Test Case 1: Divide 24 by 6
        num1 <= 8'b01110101; num2 <= 8'b10100000;
        
        repeat(10) @(posedge clk);
        $finish;
    end

    // Monitor output signals
    initial begin
        $monitor("At time %t: num1 = %d, num2 = %d, quotient = %d, remainder = %d, normalize = %b, divisionReady = %b", 
                 $time, num1, num2, quotient, remainder, normalize, divisionReady);
    end

endmodule

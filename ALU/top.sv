module topModule (
    input wire clk_50m,
    input wire Rx, 
	 input wire [1:0] control,
    output wire [6:0] seg_out1, seg_out2, seg_out3, seg_out4, seg_out5, seg_out6, seg_out7, seg_out8, // Flattened 7x8 array to a single dimension
    output wire ready,
	 output wire Tx, Tx_busy
);

    wire Rxclk_en, Txclk_en;
	 reg wr_en;
    wire [31:0] data_out, num1, num2; 
	 reg [31:0] sum;

    // Receiver module instance
    receiver Receiver (
        .Rx(Rx),
        .ready(ready),          // 1-bit output
        .clk_50m(clk_50m),      
        .clken(Rxclk_en),
        .data_out1(num1),
		  .data_out2(num2)		  // 32-bit output
    );

    // Baudrate generator instance
    baudrate Baudrate (
        .clk_50m(clk_50m),
        .Rxclk_en(Rxclk_en),
        .Txclk_en(Txclk_en)
    );
	 
	 assign data_out = (control == 2'b10)?  num2 : (control == 2'b00)?  sum: num1;

    always @(posedge clk_50m) begin
        if (ready) begin
            sum <= num1 + num2; // Perform addition
            wr_en <= 1'b1;         // Enable the transmitter
        end else begin
            wr_en <= 1'b0;         // Disable transmitter
        end
    end	 
	 
	 
	 
	 transmitter Transmitter(	
		 .data_in(sum), //input data as an 8-bit regsiter/vector 
		 .wr_en(wr_en), //enable wire to start 
		 .clk_50m(clk_50m),
		 .clken(Txclk_en), //clock signal for the transmitter
		 .Tx(Tx), //a single 1-bit register variable to hold transmitting bit
		 .Tx_busy(Tx_busy) //transmitter is busy signal 
	 );

    // Seven-segment display instances (using generate block)
	seven_segment_display segA (
                .num(data_out[3 : 0]),  
                .seg(seg_out1)              
            );
					 seven_segment_display segB (
                .num(data_out[7 : 4]),  
                .seg(seg_out2)              
            );
					 seven_segment_display segC (
                .num(data_out[11 : 8]),  
                .seg(seg_out3)              
            );
					 seven_segment_display segD (
                .num(data_out[15 : 12]),  
                .seg(seg_out4)              
            );
					 seven_segment_display segE (
                .num(data_out[19 : 16]),  
                .seg(seg_out5)              
            );
					 seven_segment_display segF (
                .num(data_out[23 : 20]),  
                .seg(seg_out6)              
            );
					 seven_segment_display segG (
                .num(data_out[27 : 24]),  
                .seg(seg_out7)              
            );
					 seven_segment_display segH (
                .num(data_out[31 : 28]),  
                .seg(seg_out8)              
            );

endmodule

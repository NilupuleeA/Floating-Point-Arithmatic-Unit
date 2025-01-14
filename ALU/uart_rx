module receiver  (input wire Rx,
						output reg ready,			// default 1 bit reg
						input wire clk_50m,		
						input wire clken,
//						input wire ready_clr,
						output reg [31:0] data_out1, data_out2	// 8 bit register
						);
initial 
begin
	ready = 1'b0; // initialize ready = 0
	data_out1 = 32'b0; // initialize data as 00000000
	data_out2 = 32'b0;
end


// Define the 3 states using 00,01,10 signals
parameter RX_STATE_START	= 2'b00;
parameter RX_STATE_DATA		= 2'b01;
parameter RX_STATE_STOP		= 2'b10;
parameter Ready_clearing   = 2'b11;

reg [2:0] words = 0;
reg [1:0] state = RX_STATE_START; // state is a 2-bit register/vector,initially equal to 00
reg [3:0] sample = 0; // This is a 4-bit register  
reg [3:0] bit_pos = 0; // bit position is a 4-bit register/vector, initially equal to 0000
reg [7:0] scratch = 8'b0; // An 8-bit register assigned to 00000000

always @(posedge clk_50m) 
begin
//	if (ready_clr)
//		ready <= 1'b0; // This resets ready to 0

	if (clken) 
	begin
		
		case (state)          // Let us consider the 3 states of the receiver 
		
		
		RX_STATE_START:       // We define condtions for starting the receiver 
		begin 
			if (!Rx || sample != 0) // start counting from the first low sample
				sample <= sample + 4'b1; // increment by 0001
				
			if (sample == 15)           // once a full bit has been sampled
			begin 
				state <= RX_STATE_DATA; //	start collecting data bits
				bit_pos <= 0;
				sample <= 0; 
				scratch <= 0;
			end
		end
		
		
		
		RX_STATE_DATA:      // We define conditions for starting the data colleting
		begin 
			sample <= sample + 4'b1;  // increment by 0001
			if (sample == 4'h8) begin // we keep assigning Rx data until all bits have 01 to 7
				scratch[bit_pos[2:0]] <= Rx;
				bit_pos <= bit_pos + 4'b1; // increment by 0001
			end
			if (bit_pos == 8 && sample == 15) begin // when a full bit has been sampled and 
				state <= RX_STATE_STOP;	// bit position has finally reached 7, assign state to stop
		
			end	

		end
		
		
		
		RX_STATE_STOP: 
		begin
			
			// * Our baud clock may not be running at exactly the
			// * same rate as the transmitter.  If we think that
			// * we're at least half way into the stop bit, allow
			// * transition into handling the next start bit.
			
			if (sample == 15 || (sample >= 8 && !Rx)) 
			begin
				state <= Ready_clearing;
				case (words)
						  3'b111: data_out2[7:0]   <= scratch;
                    3'b110: data_out2[15:8]  <= scratch;
                    3'b101: data_out2[23:16] <= scratch;
                    3'b100: data_out2[31:24] <= scratch;
						  3'b011: data_out1[7:0]   <= scratch;
                    3'b010: data_out1[15:8]  <= scratch;
                    3'b001: data_out1[23:16] <= scratch;
                    3'b000: data_out1[31:24] <= scratch;
            endcase
				sample <= 0;
				words <= words + 2'b1;
				if (words == 7)
					ready <= 1'b1;
                    
			end 
			else begin
				sample <= sample + 4'b1;
			end
			
		end
		
		Ready_clearing:
		begin
			state <= RX_STATE_START;
	
			ready <= 1'b0;
		end
		
		
		default: 
		begin
			state <= RX_STATE_START; // always begin with state assigned to START
		end
		
		endcase
	end
end

endmodule 


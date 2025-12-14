
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        done <= 1'b0;
        data_reg <= 8'b0;
        bit_counter <= 3'b0;
    end else begin
        case (state)
            IDLE: begin
                // Wait for the start bit to be low and validate it by staying here till in becomes high again
                if (!in) begin
                    next_state <= START_BIT;
                end else begin
                    next_state <= IDLE;  // Remain in IDLE until a valid start bit is detected
                end

            end
            
            START_BIT: begin
                // Confirm that the line is low for at least two clock cycles before transitioning
                if (!in) begin
                    data_reg <= 8'b0;
                    bit_counter <= 3'b0;
                    next_state <= RECEIVE_DATA;  // Proceed to receiving data only after confirming start bit
                end else begin
                    next_state <= IDLE;  // Invalid start, return to IDLE
                end
            end
            
            RECEIVE_DATA: begin
                // Capture each incoming data bit and count the bits received
                data_reg <= {data_reg[6:0], in};
                
                if (bit_counter == 3'b111) begin  // After receiving all 8 data bits
                    next_state <= STOP_BIT;
                end else begin
                    bit_counter <= bit_counter + 1'b1;  // Increment bit counter for each clock cycle
                end
            end
            
            STOP_BIT: begin
                // Check if stop bit is high, remain here until it becomes valid (in == 1)
                if (in) begin
                    done <= 1'b1;  // Valid byte received
                    next_state <= IDLE;
                end else begin
                    next_state <= STOP_BIT;  // Keep checking for a valid stop bit
                end
            end
            
        endcase

        state <= next_state;  // Update the current state at the end of each cycle
    end
end


// VERILOG-EVAL: endmodule not found

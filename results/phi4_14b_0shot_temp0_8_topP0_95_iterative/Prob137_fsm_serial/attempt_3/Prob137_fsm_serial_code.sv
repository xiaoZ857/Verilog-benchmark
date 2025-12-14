
module TopModule (
  input clk,
  input in,
  input reset,
  output reg done
);

    // State encoding
    parameter IDLE = 3'b000;
    parameter START_BIT = 3'b001;
    parameter RECEIVE_DATA = 3'b010;
    parameter STOP_BIT = 3'b011;

    reg [2:0] state, next_state;
    reg [7:0] data_reg;
    reg [2:0] bit_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
            data_reg <= 8'b0;
            bit_counter <= 3'b0;
        end else begin
            // State transition logic
            case (state)
                IDLE: begin
                    // Transition to START_BIT on detecting low signal
                    if (!in) begin
                        next_state <= START_BIT;
                    end else begin
                        next_state <= IDLE;  // Remain in IDLE until a valid start bit is detected
                    end
                end
                
                START_BIT: begin
                    // Confirm the start bit by ensuring it stays low for at least two cycles
                    if (!in) begin
                        data_reg <= 8'b0;
                        bit_counter <= 3'b0;
                        next_state <= RECEIVE_DATA;  // Proceed to receiving data after confirming start bit
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

endmodule

// VERILOG-EVAL: errant inclusion of module definition

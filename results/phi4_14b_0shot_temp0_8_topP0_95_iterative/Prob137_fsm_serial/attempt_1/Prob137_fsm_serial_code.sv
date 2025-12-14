
module TopModule (
  input clk,
  input in,        // Serial data input
  input reset,     // Active-high synchronous reset
  output reg done  // Indicates a byte has been correctly received
);

// State encoding
localparam IDLE = 3'b000;
localparam START_BIT = 3'b001;
localparam RECEIVE_DATA = 3'b010;
localparam STOP_BIT = 3'b011;

reg [2:0] state, next_state; // Current and next state registers

// Data register to store received bits
reg [7:0] data_reg;

// Bit counter for receiving 8 data bits
reg [2:0] bit_counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        done <= 1'b0;
        data_reg <= 8'b0;
        bit_counter <= 3'b0;
    end else begin
        state <= next_state;
        
        // Handle transitions and actions based on states
        case (state)
            IDLE: begin
                if (!in) begin
                    data_reg <= 8'b0;
                    bit_counter <= 3'b0;
                    done <= 1'b0;
                    next_state <= START_BIT;
                end else begin
                    next_state <= IDLE;
                end
            end
            
            START_BIT: begin
                // Wait for the start bit to be low, then move to data reception
                if (in) begin
                    next_state <= STOP_BIT; // Invalid start bit, go to stop detection
                end else begin
                    next_state <= RECEIVE_DATA;
                end
            end
            
            RECEIVE_DATA: begin
                // Shift in received bits
                data_reg <= {data_reg[6:0], in};
                if (bit_counter == 3'b111) begin
                    next_state <= STOP_BIT;
                end else begin
                    bit_counter <= bit_counter + 1'b1;
                end
            end
            
            STOP_BIT: begin
                // Check if stop bit is high
                if (in) begin
                    done <= 1'b1; // Valid byte received
                end else begin
                    next_state <= IDLE; // Invalid stop bit, wait for next start bit
                end
            end
            
        endcase
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

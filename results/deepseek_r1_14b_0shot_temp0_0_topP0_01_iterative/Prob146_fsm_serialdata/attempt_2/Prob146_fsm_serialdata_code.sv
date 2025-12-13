
module TopModule (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

typedef enum {
  START = 1,
  DATA_RECEIVING,
  STOP_CHECK
} state_t;

state_t current_state, next_state;
reg [2:0] bit_count;
reg [7:0] received_data;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    current_state <= START;
    bit_count <= 0;
    received_data <= 0;
    done <= 0;
  end else begin
    current_state <= next_state;
    case (current_state)
      START: begin
        if (in == 0) begin // Start bit detected
          next_state <= DATA_RECEIVING;
          bit_count <= 1; // First data bit expected next
        end else begin
          next_state <= START;
        end
      end
      
      DATA_RECEIVING: begin
        received_data = {received_data[6:0], in}; // Shift right and add new bit (LSB first)
        bit_count++;
        if (bit_count == 8) begin // All data bits received
          next_state <= STOP_CHECK;
        end else begin
          next_state <= DATA_RECEIVING;
        end
      end
      
      STOP_CHECK: begin
        if (in == 1) begin // Stop bit detected
          out_byte <= received_data;
          done <= 1;
          next_state <= START; // Wait for next start bit
        end else begin
          next_state <= STOP_CHECK; // Wait until stop bit is found
        end
      end
    endcase
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

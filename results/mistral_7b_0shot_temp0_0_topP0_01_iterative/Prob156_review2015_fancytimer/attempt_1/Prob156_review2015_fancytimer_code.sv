
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);
module Timer (
  input wire clk,
  input wire reset,
  input wire data,
  output reg [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

reg [2:0] pattern_buffer = {3'b000, 3'b000, 3'b000, 3'b000}; // Buffer for the start sequence (1101)
reg [3:0] delay = {4'b0, 4'b0}; // Delay counter
reg current_state; // Current state of the state machine
reg counting_counter; // Counter for counting cycles during counting phase
reg remaining_time; // Remaining time in clock cycles

always @(posedge clk) begin
  if (reset) begin
    pattern_buffer <= {3'b0, 3'b0, 3'b0, 3'b0};
    delay <= {4'b0, 4'b0};
    current_state <= START;
    counting_counter <= 0;
    remaining_time <= delay;
    counting <= 0;
    done <= 1'b0;
  end

  // State machine
  case (current_state)
    START: begin
      if (data == pattern_buffer[2]) begin
        pattern_buffer[3] <= data;
        if (pattern_buffer[2] == 3'b11 && pattern_buffer[3] == 3'b01) begin
          current_state <= SHIFT;
          delay[3] <= data;
        end
      end
    end,

    SHIFT: begin
      if (data == 3'b0) begin
        current_state <= WAIT;
        delay[2] <= delay[3];
        delay[3] <= data;
      end else begin
        delay[3] <= data;
      end
    end,

    WAIT: begin
      if (data == 3'b1) begin
        current_state <= COUNTING;
        counting <= 1'b1;
      end
    end,

    COUNTING: begin
      if (counting_counter < remaining_time + 1000) begin
        counting_counter += 1;
        count <= delay;
        remaining_time -= 1;
      end else begin
        current_state <= WAIT_ACK;
        counting <= 1'b0;
      end
    end,

    WAIT_ACK: begin
        if (ack == 1) begin
          current_state <= START;
        end
      end
  endcase
end

// Define the states
parameter START = 0;
parameter SHIFT = 1;
parameter WAIT = 2;
parameter COUNTING = 3;
parameter WAIT_ACK = 4;

// VERILOG-EVAL: endmodule not found

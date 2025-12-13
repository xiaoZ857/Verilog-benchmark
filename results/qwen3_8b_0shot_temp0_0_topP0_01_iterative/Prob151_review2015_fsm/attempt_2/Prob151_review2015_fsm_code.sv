
module TopModule (
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);

typedef enum reg [2:0] {
  S_SEARCH,      // Searching for 1101
  S_SHIFT,       // Shifting in 4 bits
  S_COUNT,       // Waiting for counters to finish
  S_DONE,        // Notifying user
  S_ACK          // Waiting for acknowledgment
} state_t;

state_t state, next_state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= S_SEARCH;
    shift_ena <= 1'b0;
    counting <= 1'b0;
    done <= 1'b0;
  end else begin
    state <= next_state;
    shift_ena <= (state == S_SHIFT) ? 1'b1 : 1'b0;
    counting <= (state == S_COUNT) ? 1'b1 : 1'b0;
    done <= (state == S_DONE) ? 1'b1 : 1'b0;
  end
end

always @(*) begin
  next_state = state;
  
  case (state)
    S_SEARCH: begin
      if (data == 4'b1101) begin
        next_state = S_SHIFT;
      end else begin
        next_state = S_SEARCH;
      end
    end
    
    S_SHIFT: begin
      if (data == 4'b1101) begin
        next_state = S_COUNT

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found

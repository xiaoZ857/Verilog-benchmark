
module TopModule (
  input wire clk,
  input wire areset,
  input wire train_valid,
  input wire train_taken,
  output reg [1:0] state
);

always @(posedge clk) begin
  if (!areset) begin
    state <= 2'b01; // Reset counter to weakly not-taken (2'b01) when areset is asserted
  end else if (train_valid && train_taken) begin
    state <= state + 1; // Counter increments up to maximum of 3 when train_valid = 1 and train_taken = 1
    if (state == 3'b11) state <= 2'b00; // Saturate at maximum value (3)
  end else if (train_valid && !train_taken) begin
    state <= state - 1; // Counter decrements down to minimum of 0 when train_valid = 1 and train_taken = 0
    if (state == 2'b00) state <= 2'b11; // Saturate at minimum value (0)
  end
end

// Assign output state to the two-bit counter value
assign state[1:0] = state;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found

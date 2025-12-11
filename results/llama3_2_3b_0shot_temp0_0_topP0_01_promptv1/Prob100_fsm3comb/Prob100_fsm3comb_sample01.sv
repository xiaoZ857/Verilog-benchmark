
module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);
assign next_state = {state[1], state[0]};
assign out = (state == 2'b00) ? 1 : 0;

// VERILOG-EVAL: endmodule not found

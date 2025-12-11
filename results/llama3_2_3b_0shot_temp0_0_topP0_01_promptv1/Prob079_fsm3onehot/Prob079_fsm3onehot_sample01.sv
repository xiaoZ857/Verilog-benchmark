
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
assign next_state = {in, state};
assign out = (state == 4'b0001) ? 1 : 0;

// VERILOG-EVAL: endmodule not found

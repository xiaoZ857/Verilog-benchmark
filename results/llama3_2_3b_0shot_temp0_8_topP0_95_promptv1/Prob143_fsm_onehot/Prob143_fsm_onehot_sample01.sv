
module TopModule (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2
);
assign next_state = {state[1:0], state[3:2]};
assign out1 = (state == 7'b000) || (state == 7'b010);
assign out2 = (state == 7'b110) || (state == 7'b101);

// VERILOG-EVAL: endmodule not found

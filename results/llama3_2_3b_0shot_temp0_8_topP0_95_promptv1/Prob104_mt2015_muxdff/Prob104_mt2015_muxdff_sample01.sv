
module TopModule (
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q
);
assign Q = {q_in[1], q_in[0], q_in[2]};

// VERILOG-EVAL: endmodule not found

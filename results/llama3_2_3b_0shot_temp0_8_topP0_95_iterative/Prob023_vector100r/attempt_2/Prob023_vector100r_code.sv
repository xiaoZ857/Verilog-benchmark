
module TopModule (
  input [99:0] in,
  output reg [99:0] out
);
// Logic to reverse bit ordering
always reg @(*) out = {in[99], in[98:0]};

// VERILOG-EVAL: endmodule not found

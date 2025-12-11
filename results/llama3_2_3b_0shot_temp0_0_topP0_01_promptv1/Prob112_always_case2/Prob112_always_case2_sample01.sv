
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
assign pos = $signed(in[2:0]) > $signed(in[1:0]) ? 2'd1 : ($signed(in[2:0]) == $signed(in[1:0])) ? 2'd0 : 2'd1;

// VERILOG-EVAL: endmodule not found


module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
assign out = $countmasm(in[254:0]);

// VERILOG-EVAL: endmodule not found

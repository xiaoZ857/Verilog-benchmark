
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);
assign q = (ar) ? 1'b0 : ((d & ~q) ? d : q);

// VERILOG-EVAL: endmodule not found

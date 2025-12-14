
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
  always @(a, b, c, d) begin
    out = (c) | (a & b & d);
  end

// VERILOG-EVAL: endmodule not found

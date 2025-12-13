
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
always_comb begin
  out = ~((a & b) | (~c & d));
end

// VERILOG-EVAL: endmodule not found

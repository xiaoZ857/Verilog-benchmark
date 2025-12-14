
module TopModule (
  input a,
  input b,
  output out
);
always_comb begin
  out = (~a & ~b) | (a & b);
end

// VERILOG-EVAL: endmodule not found

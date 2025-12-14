
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
assign out_sop = (a^b^c) | (a^b^d) | (a^c^d);

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found

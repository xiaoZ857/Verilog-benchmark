
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = (!a && b && d) || 
           (a && ((!b && d) || (!b && c) || (b && d)));

// VERILOG-EVAL: endmodule not found

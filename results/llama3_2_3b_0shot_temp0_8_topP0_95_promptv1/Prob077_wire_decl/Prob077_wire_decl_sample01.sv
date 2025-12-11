
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);
assign and1 = a & b;
assign or1 = c | d;

assign out = and1 | or1;

assign out_n = ~out;

// VERILOG-EVAL: endmodule not found

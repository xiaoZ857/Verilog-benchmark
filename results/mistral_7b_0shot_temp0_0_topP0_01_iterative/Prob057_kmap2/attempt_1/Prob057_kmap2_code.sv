
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out
);

// Create a 2x2 product term for each combination of ab and cd
wire p00 = (!a | !b) & (!c | !d);
wire p01 = (a | b) & (!c | !d);
wire p10 = (a | b) & (c | d);
wire p11 = (!a | !b) & (c | d);

// Combine the product terms to form the final output
assign out = p00 | p01 | p10 | p11;

endmodule

// VERILOG-EVAL: errant inclusion of module definition


module TopModule (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);
// Calculate out_sop in minimum sum-of-products form
assign out_sop = a[two] & b[two] & c[two] & d[two] |
                ~ (a[zero] | a[one]) & ~ (b[zero] | b[one]) & 
                 ~ (c[zero] | c[one]) & ~ (d[zero] | d[one]);

// Calculate out_pos in minimum product-of-sums form
assign out_pos = ~(a[two] | a[seven] | a[fifteen]) & 
                ~(b[two] | b[seven] | b[fifteen]) & 
                 ~(c[two] | c[seven] | c[fifteen]) & 
                 ~(d[two] | d[seven] | d[fifteen]);

endmodule


module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
assign q = ~(a ^ b) & !c | (a & b) & c;

// OR gate for 'd' using De Morgan's law
assign or_d = ~(~a & ~b);

// AND gate for 'c' and the OR of 'a' and 'b'
assign and_cb = c & or_d;

// Invert the output 'q'
assign q = ~and_cb;

// VERILOG-EVAL: endmodule not found

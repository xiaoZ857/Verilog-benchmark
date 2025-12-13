
module TopModule (
  input a,
  input b,
  input c,
  output w,
  output x,
  output y,
  output z
);

assign w = a; // Assign signal 'a' to 'w'
assign x = b; // Assign signal 'b' to 'x'
assign y = b; // Assign signal 'b' to 'y' (same as 'x')
assign z = c; // Assign signal 'c' to 'z'

endmodule

// VERILOG-EVAL: errant inclusion of module definition


module TopModule (
  input a,
  input b,
  input c,
  output w,
  output x,
  output y,
  output z
);

assign w = a; // Assign 'a' to 'w'
assign x = b; // Assign 'b' to 'x'
assign y = b; // Assign 'b' to 'y'
assign z = c; // Assign 'c' to 'z'

endmodule

// VERILOG-EVAL: errant inclusion of module definition

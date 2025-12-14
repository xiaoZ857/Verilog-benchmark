
module TopModule (
  input [2:0] vec,
  output [2:0] outv,
  output o2,
  output o1,
  output o0
);
  
  // Assign the entire vector to the output
  outv = vec;
  
  // Split each bit into individual outputs
  o0 = vec[0];
  o1 = vec[1];
  o2 = vec[2];
endmodule

// VERILOG-EVAL: errant inclusion of module definition

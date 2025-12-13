
module TopModule (
  input a, 
  input b, 
  input c, 
  output out
);

// Define the logic for each combination of inputs
assign out = (a & ~b) | (~c & b) | (c & b);

endmodule

// VERILOG-EVAL: errant inclusion of module definition


// Create a module that implements an XNOR gate
module TopModule (
  input a,
  input b,
  output out
);

  // Always block to calculate the output of XNOR gate
  always @(*)
    begin
      // Calculate the output using an XOR operation
      out = (a == b) ? 1 : 0;
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

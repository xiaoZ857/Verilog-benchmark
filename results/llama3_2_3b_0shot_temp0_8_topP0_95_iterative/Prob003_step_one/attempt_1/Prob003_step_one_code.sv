
// Define the TopModule module
module TopModule (
  // Output signal: always drives to 1 (logic high)
  output one
);

// Always block to drive the output to 1
always @(*) begin
  one = 1;
end

// End of module definition
endmodule // TopModule

// VERILOG-EVAL: errant inclusion of module definition

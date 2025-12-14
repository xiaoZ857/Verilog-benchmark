
// Define the module that will hold the D flip-flop
module TopModule (
  // Input signal for the clock (rising edge)
  input clk,

  // Input signal for the data to be stored in the flip-flop
  input d,

  // Output signal representing the current state of the flip-flop
  output reg q
);

// Create a D flip-flop inside this module
always @(posedge clk) begin

  // The next value of 'q' is either the current 'd' if 'clk' is rising edge, 
  // or the old value of 'q'
  q <= d;

end

// Instantiate an instance of TopModule (you could also use a single module with a netlist)
module DFF (
  input clk,
  input d,
  output reg q
);

 instantiate TopModule top_module (
  .clk(clk),
  .d(d),
  .q(q)
);

endmodule

// VERILOG-EVAL: errant inclusion of module definition

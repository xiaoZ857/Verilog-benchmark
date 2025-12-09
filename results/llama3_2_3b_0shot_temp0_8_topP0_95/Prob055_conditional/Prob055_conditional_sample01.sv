
// Define the module TopModule that finds the minimum of four unsigned numbers
module TopModule (
  // Inputs are the four unsigned numbers to compare
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  // Output is the minimum value among the four inputs
  output reg [7:0] min
);

// Instantiate a separate module to find the minimum
module MinFinder (
  input [7:0] num1,
  input [7:0] num2,
  output reg [7:0] result
);

  // Assign the smaller of two numbers to 'result'
  assign result = num1 < num2 ? num1 : num2;

endmodule

// Connect the inputs and outputs according to the described behavior
// a and b are compared in MinFinder, the winner goes to min, then c and d are compared with it
assign min = 
  MinFinder(a, b) < MinFinder(c, d) ? 
  MinFinder(a, b) : 
  MinFinder(c, d);

// VERILOG-EVAL: errant inclusion of module definition

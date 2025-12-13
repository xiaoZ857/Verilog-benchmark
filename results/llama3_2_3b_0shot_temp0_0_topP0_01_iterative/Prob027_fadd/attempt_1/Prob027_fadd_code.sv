
module TopModule (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
// Full Adder Module

module FullAdder(
    // Inputs
    input [1:0] a,      // First bit to be added
    input [1:0] b,      // Second bit to be added
    input cin,         // Carry-in from previous adder
    output [2:0] sum,   // Sum of the three bits
    output cout        // Carry-out after addition
);

// Internal signals for the full adder
wire temp_sum;
wire temp_cout;

// Full Adder logic
assign temp_sum = a + b + cin;
assign temp_cout = (a + b + cin) > 2'd3 ? 1'b1 : 1'b0;

// Output signals
assign sum[2] = temp_sum;
assign cout = temp_cout;

endmodule

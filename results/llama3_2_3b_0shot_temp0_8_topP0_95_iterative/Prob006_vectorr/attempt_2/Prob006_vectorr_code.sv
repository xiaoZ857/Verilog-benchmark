
module TopModule (
  input [7:0] in,
  output [7:0] out
);
// Internal signal to store the reversed bit order
reg [7:0] temp;

// Behavioral description of the module
always_comb {
  // Reversing the bit order using arithmetic operations
  temp = $unsigned(in) ^ ($unsigned(in) >> 4) & 0xAAAAAA00 | ($unsigned(in) << 4) & 0xAAAAAAAA;
}

// Combining the signals
assign out = temp;

endmodule

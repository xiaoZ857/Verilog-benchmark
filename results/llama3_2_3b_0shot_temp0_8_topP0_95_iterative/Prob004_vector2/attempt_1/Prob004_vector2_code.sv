
// Module to reverse the byte order of a 32-bit vector

module TopModule (
  // Input: 32-bit unsigned integer
  input [31:0] in,

  // Output: Reversed 32-bit unsigned integer
  output reg [31:0] out
);

// Initialize output as zero (assuming all bits are set to 0)
reg [31:0] out = 0;

// Function to reverse byte order of a 32-bit vector
function void reverseByteOrder(
  // Input: 32-bit unsigned integer
  input reg [31:0] in,

  // Output buffer
  output reg [31:0] out
) begin

  // Initialize output as zero (assuming all bits are set to 0)
  out = 0;

  // Iterate over each bit of the input vector
  for (int i = 31; i >= 0; --i) begin

    // Check if the current bit position is even or odd
    if (i % 2 == 1) begin

      // If the bit position is odd, swap it with the corresponding bit at an offset of 32-i-1
      out = out | (((in[31] & (1 << i)) >> (i + 1)) << (31 - (32 - i)));

    end else begin

      // If the bit position is even, just add the current bit to the output buffer
      out = out | ((in[31] & (1 << i)) << (31 - i));
    end
  end
endfunction

// Register the function as a module that takes the input vector and its size as arguments
module TopModule_top(
  // Input: 32-bit unsigned integer
  input [31:0] in,

  // Output buffer
  output reg [31:0] out
);

  // Instantiate the reverseByteOrder function with the input vector
  TopModule_bottom u1 (
    .in(in),
    .out(out)
  );

endmodule

// Module that implements the reverseByteOrder function
module TopModule_bottom(
  // Input: 32-bit unsigned integer
  input reg [31:0] in,

  // Output buffer
  output reg [31:0] out
);

  // Call the reverseByteOrder function with the input vector and output buffer
  reverseByteOrder(in, out);

endmodule

// VERILOG-EVAL: errant inclusion of module definition

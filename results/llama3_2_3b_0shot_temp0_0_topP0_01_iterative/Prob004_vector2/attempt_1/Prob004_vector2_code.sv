
// Reverses the byte order of a 32-bit vector
module TopModule (
  input [31:0] in,
  output [31:0] out
);

// Define the number of bits in a byte
define BIT_WIDTH 8

// Calculate the total number of bytes in the 32-bit vector
define TOTAL_BYTES (32 / BIT_WIDTH)

// Initialize the output signal to zero
assign out = 0;

// Loop through each byte in the input vector
for (int i = 0; i < TOTAL_BYTES; i++) begin : byte_loop
    // Extract the current byte from the input vector
    assign out[BIT_WIDTH * i] = in[BIT_WIDTH * (TOTAL_BYTES - i) - 1];

endfor

// End of module definition
endmodule

// VERILOG-EVAL: errant inclusion of module definition

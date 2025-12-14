
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
// Bitwidth for the output
const int BITWIDTH = 3;

// Define the possible output values
typedef enum reg [BITWIDTH-1:0] {
    ZERO,
    ONE,
    TWO
} OutputType;

// Assign an output value to each bit position (starting from least significant)
assign pos = in[2:0];

// VERILOG-EVAL: endmodule not found

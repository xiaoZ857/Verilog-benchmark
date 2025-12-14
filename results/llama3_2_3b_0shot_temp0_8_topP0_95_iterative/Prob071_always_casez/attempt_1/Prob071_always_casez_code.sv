
// Priority Encoder Module

module TopModule (
    input [7:0] in, // 8-bit input vector
    output reg [2:0] pos // 3-bit priority encoded output
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
Assign assign
    pos = in[BITWIDTH-1:1];
endmodule

// In case of no matches, add the next higher value
Assign assign
    pos = {pos, 3'b0};

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition

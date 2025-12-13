
module TopModule (
  input [7:0] in,
  output parity
);
// Parity checking module
module ParityCheckingModule(
    // Input: 8-bit byte to be checked for errors
    input [7:0] in,

    // Output: Parity bit (1 if data is odd, 0 if data is even)
    output parity
);

    // Calculate the parity bit using XOR operation
    assign parity = ~in[0];

endmodule

// Main module that combines the parity checking module with the input byte
module TopModule(
    // Input: 8-bit byte to be checked for errors
    input [7:0] in,

    // Output: Parity bit (1 if data is odd, 0 if data is even)
    output parity
);

    // Instantiate the parity checking module
    ParityCheckingModule pck(
        .in(in),
        .parity(parity)
    );

endmodule

// VERILOG-EVAL: errant inclusion of module definition

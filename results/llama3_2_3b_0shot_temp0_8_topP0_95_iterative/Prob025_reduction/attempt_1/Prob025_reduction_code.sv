
module TopModule (
  input [7:0] in,
  output parity
);
module parity_calculator(
    input [7:0] in, // Input byte to calculate parity for
    output [1:0] out // Output byte containing the calculated parity bit
);

    assign out[1] = in[0]; // Most significant bit of output is data bit from input
    assign out[0]  = ~in[7]; // Least significant bit of output is parity bit

endmodule

module TopModule (
    input [7:0] in, // Input byte to calculate parity for
    output [8:0] out, // Output containing the calculated byte and parity bit
    output parity // Output signal for setting parity flag
);

    wire [1:0] parity_bit;
    parity_calculator calc(
        .in(in),
        .out(parity_bit)
    );

    assign out = { in[7:0], parity_bit };

endmodule

// VERILOG-EVAL: errant inclusion of module definition

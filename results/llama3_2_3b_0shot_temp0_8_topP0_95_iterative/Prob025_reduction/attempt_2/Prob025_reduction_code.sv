
module TopModule (
    input [7:0] in, // Input byte to calculate parity for
    output [1:0] out // Output byte containing the calculated parity bit
);

    wire parity;
    parity_calculator calc(
        .in(in),
        .out(out)
    );

    assign out[1] = in[0]; // Most significant bit of output is data bit from input
    assign out[0]  = ~in[7]; // Least significant bit of output is parity bit
    assign parity = !~in[7];

endmodule

// VERILOG-EVAL: errant inclusion of module definition

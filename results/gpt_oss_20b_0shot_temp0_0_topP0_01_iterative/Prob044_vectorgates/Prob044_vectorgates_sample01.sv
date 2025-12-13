
// TopModule.v
// 3‑bit inputs a and b
//  • out_or_bitwise  – bit‑wise OR of a and b
//  • out_or_logical – logical OR of the two vectors (1 if any bit of a or b is 1)
//  • out_not         – 6‑bit vector: upper 3 bits = ~b, lower 3 bits = ~a
//
// All outputs are combinational (no clock required).

module TopModule (
    input  wire [2:0] a,
    input  wire [2:0] b,
    output wire [2:0] out_or_bitwise,
    output wire       out_or_logical,
    output wire [5:0] out_not
);

    // Bit‑wise OR
    assign out_or_bitwise = a | b;

    // Logical OR of the two vectors
    // Equivalent to: out_or_logical = |a | |b
    assign out_or_logical = |(a | b);

    // Inverse of both vectors
    // Upper half (bits 5:3) = ~b, lower half (bits 2:0) = ~a
    assign out_not = {~b, ~a};

endmodule

// VERILOG-EVAL: errant inclusion of module definition

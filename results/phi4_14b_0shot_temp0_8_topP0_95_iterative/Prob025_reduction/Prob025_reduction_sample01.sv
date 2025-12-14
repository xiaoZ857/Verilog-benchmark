
module TopModule (
    input [7:0] in,
    output parity
);

// Compute the even parity bit by chaining XOR operations across all 8 data bits.
assign parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

endmodule

// VERILOG-EVAL: errant inclusion of module definition

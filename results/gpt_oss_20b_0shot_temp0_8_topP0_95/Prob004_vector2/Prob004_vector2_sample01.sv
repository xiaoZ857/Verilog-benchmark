
// 32‑bit byte‑order reverse
//   in  = [31:24][23:16][15:8][7:0]   (MSB … LSB)
//   out = [7:0][15:8][23:16][31:24]   (reversed)
module TopModule (
    input  wire [31:0] in,
    output wire [31:0] out
);

    // Assign each byte of the output to the corresponding byte of the input
    assign out[31:24] = in[7:0];
    assign out[23:16] = in[15:8];
    assign out[15:8]  = in[23:16];
    assign out[7:0]   = in[31:24];

endmodule

// VERILOG-EVAL: errant inclusion of module definition


// TopModule.v
// ---------------
// Concatenates six 5‑bit inputs into a 30‑bit value, appends two '1' bits,
// then splits the 32‑bit result into four 8‑bit outputs.
//
//   w = bits[31:24]   // MSB slice
//   x = bits[23:16]
//   y = bits[15:8]
//   z = bits[7:0]     // LSB slice (contains the appended '11')
//
// All logic is combinational – no clock is required.

module TopModule (
    input  wire [4:0] a,
    input  wire [4:0] b,
    input  wire [4:0] c,
    input  wire [4:0] d,
    input  wire [4:0] e,
    input  wire [4:0] f,

    output wire [7:0] w,
    output wire [7:0] x,
    output wire [7:0] y,
    output wire [7:0] z
);

    // 32‑bit temporary that holds the concatenated data plus the two '1' bits.
    wire [31:0] tmp;

    assign tmp = {a, b, c, d, e, f, 2'b11};

    // Split the 32‑bit value into four 8‑bit outputs.
    assign w = tmp[31:24];
    assign x = tmp[23:16];
    assign y = tmp[15:8];
    assign z = tmp[7:0];

endmodule

// VERILOG-EVAL: errant inclusion of module definition


// TopModule.v
// -------------
// Concatenates six 5‑bit inputs (a‑f) into a 30‑bit vector,
// appends two ‘1’ bits on the LSB side to make a 32‑bit word,
// and then splits that word into four 8‑bit outputs (w‑z).

`timescale 1ns/1ps

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

// 32‑bit word: 30‑bit concatenation of the inputs + two LSB '1' bits
wire [31:0] data;
assign data = { a, b, c, d, e, f, 2'b11 };

// Split the 32‑bit word into four 8‑bit outputs
// w gets bits [31:24], x gets [23:16], y gets [15:8], z gets [7:0]
assign { w, x, y, z } = data;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

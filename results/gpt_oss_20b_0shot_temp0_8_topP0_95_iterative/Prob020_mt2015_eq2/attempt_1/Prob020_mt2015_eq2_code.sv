
`timescale 1ns / 1ps          // (optional – useful for simulation)

module TopModule (
    input  wire [1:0] A,        // 2‑bit input A
    input  wire [1:0] B,        // 2‑bit input B
    output wire        z        // 1‑bit output
);

    // Combinational equality test
    assign z = (A == B);        // z = 1  when A == B, otherwise z = 0

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition

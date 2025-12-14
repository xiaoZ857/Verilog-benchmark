
// ---------------------------------------------------------------
//  Full‑adder – 3‑input, 1‑output (sum, carry‑out)
//  ---------------------------------------------------------------
//  a, b      – two input bits
//  cin       – carry‑in
//  sum       – sum output
//  cout      – carry‑out
//
//  The logic is purely combinational – no clock is required.
//  If you really need a clocked version you can wrap the logic
//  inside an `always @(posedge clk)` block, but for a typical
//  full adder the combinational form is preferred.
//
//  Using the `assign` statements is the most concise and
//  synthesis‑friendly implementation.
// ---------------------------------------------------------------
`timescale 1ns / 1ps

module TopModule (
    input  wire a,     // first addend bit
    input  wire b,     // second addend bit
    input  wire cin,   // carry‑in
    output wire cout,  // carry‑out
    output wire sum    // sum output
);

    // Sum: a XOR b XOR cin
    assign sum = a ^ b ^ cin;

    // Carry‑out: majority function
    // cout = (a & b) | (a & cin) | (b & cin)
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition

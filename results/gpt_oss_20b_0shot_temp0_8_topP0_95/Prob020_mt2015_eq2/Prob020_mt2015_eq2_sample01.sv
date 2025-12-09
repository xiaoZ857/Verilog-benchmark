
//====================================================================
// TopModule.v
//
// Description:
//   Two 2‑bit inputs A[1:0] and B[1:0] are compared.  The output z is
//   driven to logic‑1 when the two vectors are identical; otherwise z
//   is logic‑0.
//
//   The design is purely combinational – there is no clock edge or
//   register.  The expression `A == B` produces a 1‑bit result that
//   directly drives the output.
//
//====================================================================

`timescale 1ns / 1ps

module TopModule (
    input  wire [1:0] A,   // 2‑bit source vector
    input  wire [1:0] B,   // 2‑bit compare vector
    output wire       z    // 1 if A == B, else 0
);

    // A simple equality comparison.  The Verilog `==` operator
    // returns 1 when the vectors are equal; otherwise it returns 0.
    assign z = (A == B);

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition

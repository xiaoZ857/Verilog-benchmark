
module TopModule (
  input x,
  input y,
  output z
);
**Verilog implementation**

`timescale 1ns / 1ps

// -------------  Module A  ---------------------------------
// Implements:  z = (x ^ y) & x
module A (
    input  wire x,
    input  wire y,
    output wire z
);
    assign z = (x ^ y) & x;
endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition

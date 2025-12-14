
// TopModule.v
// ---------------------------------------------
// A simple combinational pass‑through module.
// ---------------------------------------------
// Assumes  positive‑edge clocked logic is not required.
//
// Input:  in   – source signal
// Output: out  – identical to the input (combinational)
// ---------------------------------------------
module TopModule (
  input  wire in,   // input port
  output wire out   // output port
);

  // Continuous assignment – the output follows the input immediately.
  assign out = in;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

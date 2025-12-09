
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
// ---------------------------------------------------------------
//  TopModule
//  ---------
//  One stage of an n‑bit shift register.
//  • `clk`      – clock (positive‑edge triggered)
//  • `w`        – data input to this stage (for shifting)
//  • `R`        – data to be loaded into this stage
//  • `E`        – shift enable
//  • `L`        – load enable (high priority over shift)
//  • `Q`        – register output (also the data output of this stage)
//
//  Behaviour
//  ---------
//  On each rising edge of `clk`:
//      * If L = 1  →  load:  Q ≤ R
//      * Else if E = 1

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found

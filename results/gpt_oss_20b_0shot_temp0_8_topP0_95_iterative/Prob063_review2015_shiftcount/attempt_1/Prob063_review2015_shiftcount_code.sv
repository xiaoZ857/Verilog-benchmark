
module TopModule (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q
);
**Verilog Implementation – Four‑bit Shift‑Register / Down‑Counter**

// 4‑bit shift register that can also act as a down counter.
// - When shift_ena  = 1:  data is loaded into the MSB (bit 3) and the
//   existing contents shift “down” one position.
// - When count_ena = 1:  the current 4‑bit value is decremented
//   (unsigned wrap‑around occurs automatically).
//
// The two enable signals are never asserted together, so any priority

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found

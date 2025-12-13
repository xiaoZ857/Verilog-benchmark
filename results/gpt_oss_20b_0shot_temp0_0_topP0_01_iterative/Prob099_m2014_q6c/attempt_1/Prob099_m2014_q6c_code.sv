
module TopModule (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);
**Logic equations (by inspection)**  

| Current state | w | Next state | Next‑state bit |
|---------------|---|------------|----------------|
| A (y[1])      | 0 | B (y[2])   | Y2 = 1 |
| A (y[1])      | 1 | A (y[1])   | Y2 = 0 |
| B (y[2])      | 1 | D (y[4])   | Y4 = 1 |
| C (y[3])      | 1 |

// VERILOG-EVAL: endmodule not found

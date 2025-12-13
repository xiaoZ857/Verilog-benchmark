
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
**What was wrong?**

| Problem | Why it breaks the design | Fix |
|---------|--------------------------|-----|
| `if (~out)` | `~out` is a *bit‑wise NOT* of the 8‑bit vector.  For any non‑zero result the NOT is still non‑zero

// VERILOG-EVAL: endmodule not found

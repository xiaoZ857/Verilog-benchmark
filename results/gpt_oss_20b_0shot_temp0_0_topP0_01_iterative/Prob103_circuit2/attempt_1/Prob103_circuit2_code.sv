
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
**Solution – Even‑parity (XNOR of all four inputs)**  

From the waveform we can build the truth table:

| a | b | c | d | q |
|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 1 |
| 0 | 0 | 0 | 1 | 0 |
| 0 | 0 | 1 | 0 | 0 |
| 0 | 0 | 1 | 1 | 1 |
| 

// VERILOG-EVAL: endmodule not found

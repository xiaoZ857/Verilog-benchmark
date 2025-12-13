
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
**Verilog – 4‑bit priority encoder (LSB‑first)**  

The encoder returns the index of the *first* `1` bit when scanning the
vector from the least‑significant bit (bit 0) to the most‑significant
bit (bit 3).  
If the input vector is all zeros the output is `2'b00`.

// 4‑bit priority encoder (LSB‑first)
//  input : 4‑bit vector  in[3:0]
//  output: 2‑bit position  pos[1:0]
//          pos = index of first '1' (0‑based)
//          if no '1' present → pos = 0

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found

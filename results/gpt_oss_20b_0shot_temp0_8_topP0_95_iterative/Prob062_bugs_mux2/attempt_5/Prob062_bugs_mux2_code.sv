
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
  // Use a combinational always block to correctly drive the 8‑bit output
  always_comb begin
    out = sel ? b : a;   // 2‑to‑1 mux: select b when sel is 1, otherwise a
  end

endmodule

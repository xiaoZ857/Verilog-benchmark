
module TopModule (
  input clk,
  input in,
  output logic out
);
// Initialize the flip‑flop output to a known value (0) so that the first clock edge behaves as expected.
initial begin
    out = 1'b0;
end

// Positive‑edge triggered D‑FF whose data input is the XOR of the external input `in` and
// the previous value of `out`.  The XOR is evaluated combinationally on the RHS,
// so the non‑blocking assignment ensures that the old value of `out` is used.
always_ff @(posedge clk) begin
    out <= in ^ out;   // D = in XOR out (old value)
end

// VERILOG-EVAL: endmodule not found

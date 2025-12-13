
module TopModule (
  input clk,
  input in,
  output logic out
);
// D flip‑flop whose D input is the XOR of the external input `in` and the
// current value of the output `out`.  The flip‑flop is clocked on the
// positive edge of `clk` and has no reset.
always_ff @(posedge clk) begin
    out <= in ^ out;
end

// VERILOG-EVAL: endmodule not found

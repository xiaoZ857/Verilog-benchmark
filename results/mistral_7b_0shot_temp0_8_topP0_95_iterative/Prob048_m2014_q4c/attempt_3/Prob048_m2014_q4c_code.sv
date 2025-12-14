
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
always @(posedge clk) begin
    if (r) // If reset is active high (1), hold the previous state of the flip-flop
        q_internal <= q;
    else // Otherwise, latch the input data into the flip-flop
        q_internal <= d;
end

// VERILOG-EVAL: endmodule not found

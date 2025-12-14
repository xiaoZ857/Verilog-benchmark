
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);
always @(posedge clk or posedge r) begin
  if (r) begin
    // Synchronous reset: when `r` is high, set `q` to 0
    q <= 1'b0;
  end else begin
    // D flip-flop behavior on the rising edge of the clock
    q <= d;
  end
end

endmodule

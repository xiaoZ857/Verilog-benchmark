
module TopModule (
  input clk,
  input d,
  output reg q
);
always @(posedge clk) begin
  if (posedge clk)
    q <= d; // Storing data on positive edge of clock
  else
    q <= !q; // Preserve current value on negative edge of clock
end

assign q_negedge = !q; // Invert the output to get the value for the next positive edge

endmodule

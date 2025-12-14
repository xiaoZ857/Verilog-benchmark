
module TopModule (
  input in,
  output out
);
// Initialize internal state on each clock cycle
always @(posedge clk) begin
  // The internal signal will be assigned the same value as the input on rising edges of the clock
  tmp_in <= in;
end

// Tie the output to the internal signal
assign out = tmp_in;

// To avoid an X at the top level, you can add a wire and an always block like so:
wire clk;
always @(posedge clk) begin
  // The following line is just for demonstration purposes.
  // Remove it if you don't want X at the top level of your design file.
  #1
end

endmodule

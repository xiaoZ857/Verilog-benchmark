
always @(posedge clk or posedge reset) // Positive edge-triggered assignment for clock and reset
begin
  if (reset)
    q <= 4'b0001; // Reset value is 4 bits of binary '1' to initialize counter at zero
  else if (q < 4'd15) // If the counter is less than 16, increment it
    q <= q + 1;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition


module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) // Positive edge-triggered assignment for clock and reset
begin
  if (reset)
    q <= 4'b0001; // Reset value is 4 bits of binary '1' to initialize counter at zero
  else if (q < 4'b1111) // If the counter is less than 15, increment it
    q <= q + 1;
end

// End your code with endmodule
endmodule

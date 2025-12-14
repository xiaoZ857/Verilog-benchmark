
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
always @(posedge clk or posedge reset) // Positive edge-triggered assignments on both clk and reset
begin
  if (reset)
    q <= 4'b0001; // Reset the counter to 0 (decimal 1)
  else if (q < 4'hA) // Increment the counter, loop back when it reaches 10 (decimal 9)
    q <= q + 1;
end

// Alternatively, you can use a loop to implement the counting part:
/*
always @(posedge clk or posedge reset)
begin
  if (reset)
    q <= 4'b0001;
  else
  begin
    for (int i = 0; i < 10; i = i + 1) // Loop from 0 to 9 and increment the counter after each iteration
      if (i == q) // If the current loop index matches the current count, move on to the next loop iteration
        continue;
      q <= i; // Assign the new value of the counter
    break; // Exit the loop once we've reached 10 and loop back to the reset condition
  end
end
*/

endmodule


module TopModule (
  input wire clk,
  input wire reset,
  output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    q <= 4'b0001; // Reset the counter to 0
  end else begin
    q <= q + 1; // Increment the counter
    if (q === 5'b10001) // If we reached 9, reset the counter and start over
      q <= 4'b0001;
  end
end

always @(posedge clk negedge reset) begin
  $finish; // This is for simulation to show that the reset signal has changed
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

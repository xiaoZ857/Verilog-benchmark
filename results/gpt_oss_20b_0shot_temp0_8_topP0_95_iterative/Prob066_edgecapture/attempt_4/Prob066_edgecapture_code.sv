
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);
  // Register to hold the previous state of the input vector
  reg [31:0] prev_in;

  always @(posedge clk) begin
    if (reset) begin
      // Synchronous active‑high reset – clear both the output and the previous‑state register
      out      <= 32'b0;
      prev_in  <= 32'b0;
    end else begin
      // Capture a falling edge on each bit: previous = 1 and current = 0
      out      <= out | (~in & prev_in);
      // Update the previous‑state register for the next cycle
      prev_in  <= in;
    end
  end
endmodule


module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
`timescale 1ns / 1ps

always @(posedge clk) begin
  if (reset) begin
    q <= 8'b0; // Reset all flip-flops to zero when reset is high
  end else begin
    q <= d; // Otherwise, assign the values from input 'd' to output 'q' for positive edge of clk
  end
end

// Add semicolon at the end of the if-else block

end

endmodule

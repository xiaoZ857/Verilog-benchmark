
module TopModule (
  input wire clk,
  input wire reset,
  input [7:0] d,
  output reg [7:0] q
);

always @(posedge clk) // The DFFs are clocked on the positive edge of clk
begin
  if (reset) // If reset is high, set all DFF outputs to zero
    q <= 8'b0000_0000;
  else // Else, latch the current input values to the output
    q <= d;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

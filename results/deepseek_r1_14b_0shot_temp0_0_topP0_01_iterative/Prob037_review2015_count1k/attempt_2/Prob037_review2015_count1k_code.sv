
// Fixed: Moved timescale directive outside of module definition
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);

always @(posedge clk) begin
  if (reset) begin
    q <= 0;
  end else begin
    if (q == 999) begin
      q <= 0;
    end else begin
      q <= q + 1;
    end
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

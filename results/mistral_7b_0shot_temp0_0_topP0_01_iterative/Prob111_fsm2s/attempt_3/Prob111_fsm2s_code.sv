
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    out <= 0; // Reset to OFF state and output is also set to OFF
  end else begin
    if (out == 0) begin
      if (j) out <= 1; // Transition from OFF to ON when j=1
    end else if (out == 1) begin
      if (!k) out <= 1; // Stay in ON state when k=0
      else out <= 0; // Transition from ON to OFF when k=1
    end
  end
end

// timescale directive should be outside the module definition
`timescale 1ns / 1ps

// End of module body
end

// VERILOG-EVAL: endmodule not found


module TopModule (
  input a,
  input b,
  output out
);
module XNOR_Gate (
  input wire a,
  input wire b,
  output reg out
);

always @(posedge clk) begin
  out <= ~(a ^ b); // XNOR operation
end

// Add clock input if not provided
// input wire clk;
// always @clk out <= ~(a ^ b); // XNOR operation

endmodule


module TopModule (
  input a,
  input b,
  output out
);
always @(posedge clk) begin
  out <= ~(a ^ b); // XNOR operation
end

// Add clock input if not provided
// input wire clk;

endmodule

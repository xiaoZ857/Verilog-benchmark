
module TopModule (
  input a,
  input b,
  output out
);
module NOR_Gate (
  input wire a,
  input wire b,
  output reg out
);

always @(posedge clk) begin
  out <= ~(a | b); // Xor operation and then negation to implement NOR gate
end

endmodule


module TopModule (
  input a,
  input b,
  output out
);
always @(posedge clk) begin
  out <= ~(a ^ b); // XNOR operation using XOR and NOT gates
end

// If you want to specify reset, you can use the following block. However, it's not included in your description.
// Reset input is active high (initial value 1 for reset_n)
input wire reset_n;
always @(posedge clk or negedge reset_n) begin
  if (reset_n) begin
    out <= 0; // Reset output to 0
  end else begin
    out <= ~(a ^ b); // XNOR operation
  end
end
endmodule

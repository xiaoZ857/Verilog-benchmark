
module TopModule (
  input clk,
  input in,
  output logic out
);
// Initialize the flip-flop output to 0 at time 0
initial begin
  out = 0;
end

// D flip-flop with XOR feedback
always @(posedge clk) begin
  out <= in ^ out;
end
endmodule

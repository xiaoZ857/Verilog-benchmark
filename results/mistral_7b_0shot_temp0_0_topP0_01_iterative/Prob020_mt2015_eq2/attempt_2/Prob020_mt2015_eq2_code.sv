
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);
always @(posedge clk or negedge reset) begin
  if (reset)
    z <= 1'b0;
  else if ((A == B))
    z <= 1'b1;
  else
    z <= 1'b0;
end

assign A = A;
assign B = B;

initial
  // Reset the circuit at time 0
  reset = 1'b1;
  #1 reset = 1'b0;

reg reset;

endmodule

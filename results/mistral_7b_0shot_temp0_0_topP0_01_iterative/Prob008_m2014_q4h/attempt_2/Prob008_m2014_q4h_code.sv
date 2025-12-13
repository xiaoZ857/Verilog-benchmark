
module TopModule (
  input in,
  output out
);
always @(posedge clk or posedge in) begin
  if (in)
    out <= in;
end

// If you want to make the assignment combinatorial (zero delay), uncomment the following line:
// assign out = in;

endmodule

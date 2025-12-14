
module TopModule (
  input in,
  output out
);
always @(posedge clk) begin
  out <= in;
end

initial
begin
  #1 $finish; // Exits the simulation once the initial block is completed.
end

endmodule

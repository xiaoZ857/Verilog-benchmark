
module TopModule (
  input a,
  input b,
  input sel,
  output out
);
always @(posedge clk) begin
  if (sel)
    out <= b;
  else
    out <= a;
end

// Add clock input and synchronization if needed:
input wire clk;
always @(posedge clk) $finish; // This line ensures that the changes to out are committed only on positive edge of clk.

endmodule


module TopModule (
  input [99:0] in,
  output reg [99:0] out
);
always @(posedge clk) begin
  for (int i = 0; i < 100; i++) begin
    out[i] <= in[99-i]; // Reverse bit order by indexing from the end of the vector
  end
end

// Add clock enable if needed (assuming clk_en is an input)
// always @(posedge clk and clk_en) begin
//   for (int i = 0; i < 100; i++) begin
//     out[i] <= in[99-i]; // Reverse bit order by indexing from the end of the vector
//   end
// end
endmodule

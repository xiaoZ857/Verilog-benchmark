
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
  // Detect positive edges: bits that are 1 now but were 0 in previous cycle
  pedge <= in & ~in_prev;
  // Store current input for next cycle comparison
  in_prev <= in;
end

endmodule

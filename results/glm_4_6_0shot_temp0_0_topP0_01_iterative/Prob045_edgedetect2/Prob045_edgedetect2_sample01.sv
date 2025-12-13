
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
  // Detect edges by comparing current input with previous input
  anyedge <= (in ^ in_prev);
  
  // Store current input for next comparison
  in_prev <= in;
end

endmodule

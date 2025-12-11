
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

reg [7:0] in_prev;
reg [7:0] edge_detected;

always @(posedge clk) begin
  // Store previous input value
  in_prev <= in;
  
  // Detect 0 to 1 transition
  edge_detected <= ~in_prev & in;
  
  // Output the edge detection one cycle later
  pedge <= edge_detected;
end
endmodule


module TopModule (
  input clk,
  input d,
  output reg q
);
reg pos_edge_capture;
reg neg_edge_capture;

always @(posedge clk) begin
  // Capture the input on the rising edge of the clock
  pos_edge_capture <= d;
end

always @(negedge clk) begin
  // Capture the input on the falling edge of the clock
  neg_edge_capture <= d;
end

// Update q once per clock cycle using both captured values
always @(posedge clk or negedge clk) begin
  if (clk) begin
    // On rising edge, use the value captured on the last falling edge
    q <= neg_edge_capture;
  end else begin
    // On falling edge, use the value captured on the last rising edge
    q <= pos_edge_capture;
  end
end

endmodule

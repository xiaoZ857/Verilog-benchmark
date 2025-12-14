
module TopModule (
  input clk,
  input d,
  output reg q
);

  // Internal signals for capturing data on both edges
  reg pos_edge_ff;
  reg neg_edge_ff;

  always @(posedge clk) begin
    pos_edge_ff <= d; // Capture the data on positive clock edge
  end

  always @(negedge clk) begin
    neg_edge_ff <= d; // Capture the data on negative clock edge
    q <= pos_edge_ff; // Update q with the value captured at the last positive edge
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition


module TopModule (
  input clk,
  input d,
  output reg q
);
reg pos_edge_detected;
reg neg_edge_detected;

always @(posedge clk or negedge clk) begin
    if (negedge clk)
        neg_edge_detected <= 1'b1;
    else if (posedge clk)
        neg_edge_detected <= 1'b0;
end

always @(posedge clk or negedge clk) begin
    if (posedge clk)
        pos_edge_detected <= 1'b1;
    else if (negedge clk)
        pos_edge_detected <= 1'b0;
end

always @(posedge clk or negedge clk) begin
    if (pos_edge_detected)
        q <= d;
    if (neg_edge_detected)
        q <= d;
end

endmodule

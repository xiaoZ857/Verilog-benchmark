

module TopModule (
  input clk,
  input d,
  output reg q
);

reg [1:0] edge_detect;
always @(posedge clk or negedge clk) begin
    if (clk)
        edge_detect <= {edge_detect[0], 1'b1};
    else
        edge_detect <= {edge_detect[0], 1'b0};
end

always @(posedge clk or negedge clk) begin
    if (edge_detect == 2'b01 || edge_detect == 2'b10)
        q <= d;
end
endmodule

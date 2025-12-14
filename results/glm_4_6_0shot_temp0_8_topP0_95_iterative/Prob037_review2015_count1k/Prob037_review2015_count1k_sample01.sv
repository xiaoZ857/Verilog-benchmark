
module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);

reg [9:0] next_q;

always @(posedge clk) begin
  if (reset) begin
    q <= 10'b0;
  end else begin
    q <= next_q;
  end
end

always @(*) begin
  if (q == 10'd999) begin
    next_q = 10'b0;
  end else begin
    next_q = q + 1'b1;
  end
end

endmodule

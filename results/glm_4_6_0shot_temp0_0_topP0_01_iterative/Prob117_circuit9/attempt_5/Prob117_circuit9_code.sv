
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

always @(posedge clk) begin
  if (a) begin
    q <= 3'd4;  // Set to 4 when a=1
  end else begin
    if (q == 3'd6) begin
      q <= 3'd0;  // Wrap to 0 when q=6 and a=0
    end else begin
      q <= q + 1; // Increment otherwise
    end
  end
end

endmodule

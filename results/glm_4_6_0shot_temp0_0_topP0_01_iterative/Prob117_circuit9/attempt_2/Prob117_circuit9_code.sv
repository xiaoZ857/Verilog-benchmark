
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

always @(posedge clk) begin
  if (a) begin
    q <= 3'b100; // When a=1, set q to 4
  end else begin
    q <= q + 1; // When a=0, increment q
  end
end
endmodule

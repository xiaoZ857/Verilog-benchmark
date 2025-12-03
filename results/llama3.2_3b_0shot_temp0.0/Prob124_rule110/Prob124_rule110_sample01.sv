

module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

reg [511:0] q;

always @(posedge clk)
begin
  if (load) begin
    q <= data;
  end else begin
    q <= {q[510:1], q[0]};
  end
endmodule

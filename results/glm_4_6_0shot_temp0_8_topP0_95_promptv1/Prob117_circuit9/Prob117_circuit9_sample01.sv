
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk) begin
    if (a) begin
      q <= 3'b100; // When a is 1, q stays at 4
    end else begin
      q <= q + 1; // When a is 0, q increments
    end
  end
endmodule

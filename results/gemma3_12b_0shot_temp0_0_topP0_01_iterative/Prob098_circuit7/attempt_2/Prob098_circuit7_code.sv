
module TopModule (
  input clk,
  input a,
  output reg q
);
  reg q_next;

  always @(posedge clk) begin
    if (a == 0) begin
      q <= 1;
    end else begin
      q <= ~q;
    end
  end

endmodule

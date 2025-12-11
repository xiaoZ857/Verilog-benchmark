
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
always @(posedge clk) begin
  if (y == 3'b000) begin
    Y0 <= 1'b0;
    z <= 1'b0;
  end else if (y == 3'b001) begin
    Y0 <= 1'b1;
    z <= 1'b0;
  end else if (y == 3'b010) begin
    Y0 <= 1'b0;
    z <= 1'b0;
  end else if (y == 3'b011) begin
    Y0 <= 1'b1;
    z <= 1'b1;
  end else if (y == 3'b100) begin
    Y0 <= 1'b1;
    z <= 1'b1;
  end
endmodule

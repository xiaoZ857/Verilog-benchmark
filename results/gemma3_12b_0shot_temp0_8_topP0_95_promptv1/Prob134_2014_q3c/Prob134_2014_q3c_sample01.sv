
module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);
always @(posedge clk) begin
  if (y == 3'b000) begin
    if (x == 1'b0)
      Y0 <= 1'b0;
    else
      Y0 <= 1'b1;
  end else if (y == 3'b001) begin
    if (x == 1'b0)
      Y0 <= 1'b1;
    else
      Y0 <= 1'b0;
  end else if (y == 3'b010) begin
    if (x == 1'b0)
      Y0 <= 1'b0;
    else
      Y0 <= 1'b1;
  end else if (y == 3'b011) begin
    if (x == 1'b0)
      Y0 <= 1'b1;
    else
      Y0 <= 1'b0;
  end else if (y == 3'b100) begin
    if (x == 1'b0)
      Y0 <= 1'b0;
    else
      Y0 <= 1'b1;
  end
end

always @(*) begin
  if (y == 3'b000)
    z = 0;
  else if (y == 3'b001)
    z = 0;
  else if (y == 3'b010)
    z = 0;
  else if (y == 3'b011)
    z = 1;
  else if (y == 3'b100)
    z = 1;
endmodule

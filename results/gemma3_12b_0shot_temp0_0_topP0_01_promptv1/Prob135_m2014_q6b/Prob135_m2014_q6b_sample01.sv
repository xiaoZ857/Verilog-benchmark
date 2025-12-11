
module TopModule (
  input [3:1] y,
  input w,
  output reg Y2
);
always @(y w) begin
  if (y[3:1] == 4'b0000) begin
    Y2 = y[2];
  end else if (y[3:1] == 4'b0001) begin
    Y2 = y[2];
  end else if (y[3:1] == 4'b0010) begin
    Y2 = 1'b0;
  end else if (y[3:1] == 4'b0011) begin
    Y2 = 1'b1;
  end else if (y[3:1] == 4'b0100) begin
    Y2 = 1'b0;
  end else if (y[3:1] == 4'b0101) begin
    Y2 = 1'b1;
  end else if (y[3:1] == 4'b0110) begin
    Y2 = 1'b0;
  end else if (y[3:1] == 4'b0111) begin
    Y2 = 1'b1;
  end else if (y[3:1] == 4'b1000) begin
    Y2 = 1'b0;
  end else if (y[3:1] == 4'b1001) begin
    Y2 = 1'b1;
  end else if (y[3:1] == 4'b1010) begin
    Y2 = 1'b0;
  end else if (y[3:1] == 4'b1011) begin
    Y2 = 1'b1;
  end
endmodule

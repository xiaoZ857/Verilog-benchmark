

module TopModule (
  input x,
  input y,
  output z
);

  reg z_reg;
  always @(posedge clk) begin
    if (time == 0) begin
      z_reg <= 1;
    end else if (time == 5) begin
      z_reg <= 1;
    end else if (time == 10) begin
      z_reg <= 1;
    end else if (time == 15) begin
      z_reg <= 1;
    end else if (time == 20) begin
      z_reg <= 1;
    end else if (time == 25) begin
      z_reg <= 0;
    end else if (time == 30) begin
      z_reg <= 0;
    end else if (time == 35) begin
      z_reg <= 0;
    end else if (time == 40) begin
      z_reg <= 0;
    end else if (time == 45) begin
      z_reg <= 1;
    end else if (time == 50) begin
      z_reg <= 1;
    end else if (time == 55) begin
      z_reg <= 1;
    end else if (time == 60) begin
      z_reg <= 0;
    end else if (time == 65) begin
      z_reg <= 0;
    end else if (time == 70) begin
      z_reg <= 1;
    end else if (time == 75) begin
      z_reg <= 0;
    end else if (time == 80) begin
      z_reg <= 0;
    end else if (time == 85) begin
      z_reg <= 0;
    end else if (time == 90) begin
      z_reg <= 0;
    end
  end
  assign z = z_reg;
endmodule

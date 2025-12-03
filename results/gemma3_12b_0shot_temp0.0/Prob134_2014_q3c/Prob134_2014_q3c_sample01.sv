

module TopModule (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

always @(posedge clk) begin
  case (y)
    3'b000: begin
      Y0 <= 3'b000;
    end
    3'b001: begin
      Y0 <= 3'b001;
    end
    3'b010: begin
      Y0 <= 3'b010;
    end
    3'b011: begin
      Y0 <= 3'b001;
    end
    3'b100: begin
      Y0 <= 3'b011;
    end
  endcase
end

always @(y, x) begin
  if (y == 3'b000 || y == 3'b001 || y == 3'b010) begin
    z = 0;
  end else begin
    z = 1;
  end
end

endmodule

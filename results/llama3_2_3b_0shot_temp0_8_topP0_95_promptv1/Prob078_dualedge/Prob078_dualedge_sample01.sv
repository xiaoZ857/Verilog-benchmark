
module TopModule (
  input clk,
  input d,
  output reg q
);
assign q = d & ~(d == 1'b0);

always @(*) begin
    q <= 1'b0;
end

assign q = d & ~(d == 1'b0);
endmodule

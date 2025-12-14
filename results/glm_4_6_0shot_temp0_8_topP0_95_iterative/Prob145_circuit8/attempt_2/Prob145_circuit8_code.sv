
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);

always @(clock or a) begin
  if (clock) begin
    p = a;
  end else begin
    p = 0;
  end
end

always @(negedge clock) begin
  q = p;
end

endmodule

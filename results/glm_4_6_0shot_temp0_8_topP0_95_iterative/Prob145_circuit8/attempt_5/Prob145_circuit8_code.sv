
module TopModule (
  input clock,
  input a,
  output reg p,
  output reg q
);
always @(*) begin
  if (clock) begin
    p <= a;
  end else begin
    p <= p;
  end
end

always @(posedge clock or negedge clock) begin
  if (!clock) begin
    q <= p;
  end
end

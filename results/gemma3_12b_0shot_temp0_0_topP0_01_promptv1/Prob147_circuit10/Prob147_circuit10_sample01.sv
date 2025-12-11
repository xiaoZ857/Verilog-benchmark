
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
logic state_reg;

always @(posedge clk) begin
  state_reg <= state_reg;
end

always @(posedge clk) begin
  if (a & b) begin
    q <= 1;
  end else if (a & ~b) begin
    q <= 1;
  end else if (~a & b) begin
    q <= 1;
  end else begin
    q <= 1'b0;
  end
end

assign state = state_reg;
assign q = q;
endmodule

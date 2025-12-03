

module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);

reg q;
wire next_state;

assign next_state = (a & ~b) | (~a & b);

always @(posedge clk) begin
    q <= next_state;
end

assign state = q;

endmodule

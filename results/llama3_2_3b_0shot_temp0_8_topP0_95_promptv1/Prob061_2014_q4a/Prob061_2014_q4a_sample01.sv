
module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);
assign Q = w;
assign Q[0] = R;

always @(*) begin
    if (L)
        Q[0] <= 1'b0;
    else
        Q[0] <= w;
end 

endmodule

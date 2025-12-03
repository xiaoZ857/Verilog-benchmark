

module TopModule (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

always @(posedge clk) begin
    if (L)
        Q <= R;
    else if (E)
        Q <= {Q[n-2:0], w};
end

endmodule

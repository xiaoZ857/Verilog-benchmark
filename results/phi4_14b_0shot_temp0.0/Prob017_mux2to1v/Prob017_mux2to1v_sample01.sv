

module TopModule (
  input [99:0] a,
  input [99:0] b,
  input sel,
  output [99:0] out
);

reg [99:0] mux_out;

always @(posedge clk) begin
    if (sel == 1'b0)
        mux_out <= a;
    else
        mux_out <= b;
end

assign out = mux_out;

endmodule

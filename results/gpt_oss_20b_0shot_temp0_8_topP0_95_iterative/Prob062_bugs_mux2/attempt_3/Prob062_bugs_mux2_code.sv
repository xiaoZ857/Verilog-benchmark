
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
always @(*) begin
    // Combinational 2‑to‑1 multiplexer
    out = sel ? b : a;
end

endmodule

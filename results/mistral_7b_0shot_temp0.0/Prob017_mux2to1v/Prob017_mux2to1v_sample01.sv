
module TopModule (
  input wire sel,
  input [99:0] a,
  input [99:0] b,
  output reg [99:0] out
);

always @(posedge clk) begin
  if (sel)
    out <= b;
  else
    out <= a;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

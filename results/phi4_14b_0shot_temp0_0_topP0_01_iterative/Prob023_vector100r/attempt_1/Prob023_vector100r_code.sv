
module TopModule (
  input clk,
  input [99:0] in,
  output reg [99:0] out
);

always @(posedge clk) begin
  integer i;
  for (i = 0; i < 100; i = i + 1) begin
    out[i] <= in[99 - i];
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

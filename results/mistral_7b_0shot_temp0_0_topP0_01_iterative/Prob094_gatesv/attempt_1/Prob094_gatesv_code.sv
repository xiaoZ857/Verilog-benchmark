
module TopModule (
  input [3:0] in,
  output reg [2:0] out_both,
  output reg [3:1] out_any,
  output reg [3:0] out_different
);

always @(posedge clk) begin
  // Initialize outputs to 0
  out_both <= 4'b0000;
  out_any <= 4'b0000;
  out_different <= 4'b1111;

  // Calculate out_both
  out_both[0] <= in[0];
  for (int i = 1; i < 4; i++)
    out_both[i] <= (in[i] & in[i-1]);

  // Calculate out_any
  for (int i = 1; i < 4; i++)
    out_any[i] <= (in[i] | in[i+1]);

  // Calculate out_different
  for (int i = 1; i < 4; i++)
    out_different[i] <= (in[i] ^ in[i-1]);
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found


module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);
always @(posedge clk) begin
  if (reset) begin
    q <= 0;
  end else if (!slowena && !reset) begin
    q <= q + 1;
  end else if (slowena) begin
    q <= 0;
  end
end

// VERILOG-EVAL: endmodule not found

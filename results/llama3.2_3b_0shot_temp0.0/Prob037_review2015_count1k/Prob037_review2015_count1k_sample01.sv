

module TopModule (
  input clk,
  input reset,
  output reg [9:0] q
);

always @(posedge clk) begin
    if (reset) q <= 0;
    else if (q == 999) q <= 0;
    else q <= q + 1;
end

assign q = q;

// VERILOG-EVAL: endmodule not found

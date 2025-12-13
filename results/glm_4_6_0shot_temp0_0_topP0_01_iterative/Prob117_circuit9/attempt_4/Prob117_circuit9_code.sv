
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
  if (a) begin
    q <= 3'd4;  // Hold at 4 when a=1
  end else begin
    q <= q + 1; // Increment when a=0
  end
end

// VERILOG-EVAL: endmodule not found

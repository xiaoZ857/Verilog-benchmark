
module TopModule (
  input clk,
  input slowena,
  input reset,
  output reg [3:0] q
);

always @(posedge clk) begin
  if (reset)
    q <= 0;
  else
    if (slowena)
      if (q == 9)
        q <= 0;
      else
        q <= q + 1;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

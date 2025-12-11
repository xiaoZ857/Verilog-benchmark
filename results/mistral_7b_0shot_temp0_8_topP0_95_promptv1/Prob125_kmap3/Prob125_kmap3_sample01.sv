
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output reg out
);
always @(posedge clk) begin
    if ((!(a & c)) || (b & d))
        out <= 1'b0;
    else
        out <= 1'b1;
end

// VERILOG-EVAL: endmodule not found

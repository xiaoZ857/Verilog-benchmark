
module TopModule (
  input a,
  input b,
  output reg out
);

always @(posedge clk) begin
  out <= ~(a | b);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

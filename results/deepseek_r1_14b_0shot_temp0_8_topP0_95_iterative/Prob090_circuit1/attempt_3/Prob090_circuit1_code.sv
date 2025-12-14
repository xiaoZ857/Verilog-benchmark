
module TopModule (
  input a,
  input b,
  output q
);
always @(*) begin
  q = a & b;
end

// VERILOG-EVAL: endmodule not found

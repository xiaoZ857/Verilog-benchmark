
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
always @* begin
    q = ~(a ^ b) & (c & d);
end

// VERILOG-EVAL: endmodule not found

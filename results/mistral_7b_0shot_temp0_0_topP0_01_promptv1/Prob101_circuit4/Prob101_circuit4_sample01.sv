
module TopModule (
  input a,
  input b,
  input c,
  input d,
  output q
);
always @* begin
    xor_out = a ^ b;
end

always @* begin
    and_out = c & d;
end

assign q = xor_out & and_out;

// VERILOG-EVAL: endmodule not found

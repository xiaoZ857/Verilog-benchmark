
module TopModule (
  input [99:0] in,
  output out_and,
  output out_or,
  output out_xor
);

// AND operation: all inputs must be 1 for output to be 1
assign out_and = &in;

// OR operation: any input being 1 sets output to 1
assign out_or = |in;

// XOR operation: parity of the number of 1s in the input vector
wire xor_result;
always @* begin
  xor_result = 0;
  for (int i = 0; i < 100; i++) begin
    xor_result ^= in[i];
  end
end
assign out_xor = xor_result;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

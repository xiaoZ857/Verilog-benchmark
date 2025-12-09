
module TopModule (
  input clk,
  input x,
  output z
);

  // Internal signals for flip-flop outputs
  reg ff_xor_out, ff_and_out, ff_or_out;
  
  // XOR gate output (x XOR ff_xor_out)
  wire xor_out = x ^ ff_xor_out;
  
  // AND gate output (x AND ~ff_and_out)
  wire and_out = x & ~ff_and_out;
  
  // OR gate output (x OR ~ff_or_out)
  wire or_out = x | ~ff_or_out;
  
  // Three-input NOR gate output
  assign z = ~(ff_xor_out | ff_and_out | ff_or_out);
  
  // D flip-flops (positive edge triggered)
  always @(posedge clk) begin
    ff_xor_out <= xor_out;
    ff_and_out <= and_out;
    ff_or_out <= or_out;
  end

endmodule

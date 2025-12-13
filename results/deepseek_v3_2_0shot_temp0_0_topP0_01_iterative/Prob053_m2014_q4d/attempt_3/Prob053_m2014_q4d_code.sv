
module TopModule (
  input clk,
  input in,
  output logic out
);
  logic xor_out;
  
  // Combinational XOR logic
  assign xor_out = in ^ out;
  
  // D flip-flop (positive edge triggered, no reset)
  always_ff @(posedge clk) begin
    out <= xor_out;
  end
endmodule

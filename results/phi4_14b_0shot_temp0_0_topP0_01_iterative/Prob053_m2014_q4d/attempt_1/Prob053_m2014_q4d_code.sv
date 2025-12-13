
module TopModule (
  input clk,
  input in,
  output logic out
);

  // Intermediate wire to hold the XOR result
  wire xor_out;

  // XOR gate implementation
  assign xor_out = in ^ out;

  // D flip-flop implementation
  always_ff @(posedge clk) begin
    out <= xor_out;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

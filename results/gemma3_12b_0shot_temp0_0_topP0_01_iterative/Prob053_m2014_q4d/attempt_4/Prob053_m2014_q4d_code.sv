
module TopModule (
  input clk,
  input in,
  output logic out
);
  logic q; // Internal signal for the flip-flop's output

  // D flip-flop
  always_ff @(posedge clk) begin
    q <= in;
  end

  // XOR gate
  assign xor_in = in ^ q;

  assign out = xor_in;
endmodule

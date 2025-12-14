
module TopModule (
  input clk,
  input in,
  output logic out
);
  logic q;

  // D flip-flop
  always_ff @(posedge clk) begin
    q <= in;
  end

  assign out = q;

  // XOR gate
  // assign out = in ^ q; // Original incorrect line
endmodule

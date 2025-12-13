
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

  assign out = q;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

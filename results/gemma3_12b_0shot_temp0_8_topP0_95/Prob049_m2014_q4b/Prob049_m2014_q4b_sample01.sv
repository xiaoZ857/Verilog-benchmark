
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

  logic q_next;

  always_ff @(posedge clk, posedge ar) begin
    if (ar) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

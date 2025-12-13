
module TopModule (
  input clk,
  input d,
  input ar,
  output logic q
);

  logic q_reg;

  always_ff @(posedge clk, posedge ar) begin
    if (ar) begin
      q_reg <= 1'b0;
    end else begin
      q_reg <= d;
    end
  end

  assign q = q_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

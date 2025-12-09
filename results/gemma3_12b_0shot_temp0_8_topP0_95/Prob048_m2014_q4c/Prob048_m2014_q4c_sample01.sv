
module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);

  logic q_reg;

  always_ff @(posedge clk, posedge r) begin
    if (r) begin
      q_reg <= 1'b0;
    end else begin
      q_reg <= d;
    end
  end

  assign q = q_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

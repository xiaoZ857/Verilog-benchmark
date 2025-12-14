
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);

  reg q_reg;
  reg state_reg;

  always @(posedge clk) begin
    if (clk == 1) begin
      if (a == 1 && b == 1 && state_reg == 0) begin
        state_reg <= 1;
      end else if (a == 0 && b == 0 && state_reg == 1) begin
        state_reg <= 0;
      end else if (a == 1 && b == 0 && state_reg == 1) begin
        state_reg <= 0;
      end
      else if (a == 0 && b == 0 && state_reg == 0) begin
          state_reg <= 0;
      end

      q_reg <= state_reg;
    end
  end

  assign q = q_reg;
  assign state = state_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

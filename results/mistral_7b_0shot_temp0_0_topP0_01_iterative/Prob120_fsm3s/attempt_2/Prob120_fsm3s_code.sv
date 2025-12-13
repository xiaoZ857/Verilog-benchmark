
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    state_A <= 1'b1;
    state_B <= 1'b0;
    state_C <= 1'b0;
    state_D <= 1'b0;
    out <= 1'b0;
  end else begin
    case (state_A)
      1'b1: begin
        if (in == 1'b0)
          state_B <= 1'b1;
        else
          state_B <= 1'b0;
        out <= 1'b0;
        state_C <= state_A;
        state_D <= state_A;
      end
      1'b0: begin
        if (in == 1'b1)
          state_B <= 1'b1;
        else
          state_B <= 1'b0;
        out <= 1'b0;
        state_C <= state_B;
        state_D <= state_B;
      end
    endcase

    case (state_B)
      1'b1: begin
        state_C <= 1'b1;
        state_D <= 1'b0;
        out <= 1'b0;
      end
      1'b0: begin
        state_C <= 1'b0;
        state_D <= 1'b1;
        out <= 1'b1;
      end
    endcase

    case (state_C)
      1'b1: begin
        state_A <= 1'b0;
        state_D <= 1'b0;
        out <= 1'b0;
      end
      1'b0: begin
        state_A <= 1'b1;
        state_D <= 1'b1;
        out <= 1'b0;
      end
    endcase

    case (state_D)
      1'b1: begin
        state_C <= 1'b1;
        state_B <= 1'b0;
        out <= 1'b1;
      end
      1'b0: begin
        state_C <= 1'b0;
        state_B <= 1'b1;
        out <= 1'b0;
      end
    endcase
  end
end

// Add timescale directive outside the module definition
`timescale 1ns / 1ps

// VERILOG-EVAL: endmodule not found

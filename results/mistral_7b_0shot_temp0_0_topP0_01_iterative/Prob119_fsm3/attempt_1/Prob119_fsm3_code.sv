
module TopModule (
  input wire clk,
  input wire in,
  input wire areset,
  output reg out,
  output reg state_A,
  output reg state_B,
  output reg state_C,
  output reg state_D
);

always @(posedge clk or negedge areset) begin
  if (areset) begin
    state_A <= 1'b1;
    state_B <= 1'b0;
    state_C <= 1'b0;
    state_D <= 1'b0;
    out <= 1'b0;
  end else begin
    case (state_A)
      1'b1: begin
        if (in == 1'b0) begin
          state_A <= 1'b1;
          state_B <= 1'b0;
          out <= 1'b0;
        end else begin
          state_A <= 1'b0;
          state_B <= 1'b1;
        end
      end,
      1'b0: begin
        if (in == 1'b0) begin
          state_C <= 1'b0;
          state_B <= 1'b1;
          out <= 1'b0;
        end else begin
          state_C <= 1'b1;
          state_B <= 1'b0;
          out <= 1'b0;
        end
      end,
      1'b0: begin
        if (in == 1'b0) begin
          state_A <= 1'b0;
          state_D <= 1'b0;
          out <= 1'b0;
        end else begin
          state_A <= 1'b1;
          state_C <= 1'b1;
          out <= 1'b1;
        end
      end,
      1'b0: begin
        if (in == 1'b0) begin
          state_C <= 1'b0;
          state_B <= 1'b1;
          out <= 1'b0;
        end else begin
          state_C <= 1'b1;
          state_B <= 1'b0;
          out <= 1'b0;
        end
      end
    endcase
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found

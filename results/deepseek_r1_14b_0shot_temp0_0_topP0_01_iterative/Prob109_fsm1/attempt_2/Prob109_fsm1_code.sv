
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);

  reg state;  // State definition: 0 = B, 1 = A

  always @(posedge clk or areset) begin
    if (areset) begin
      state <= 0;  // Reset to state B
    end else begin
      case (state)
        0: begin  // Current state is B
            if (in == 1) begin
              state <= 1;  // Next state A on input 1
            end else begin
              state <= 0;  // Stay in B on input 0
            end
          end
        1: begin  // Current state is A
            if (in == 0) begin
              state <= 0;  // Next state B on input 0
            end else begin
              state <= 1;  // Stay in A on input 1
            end
          end
        default: state <= 0;  // Default to state B
      endcase
    end
  end

  assign out = (state == 1) ? 1 : 0;  // Output is 1 when in state A, else 0

endmodule

// VERILOG-EVAL: errant inclusion of module definition

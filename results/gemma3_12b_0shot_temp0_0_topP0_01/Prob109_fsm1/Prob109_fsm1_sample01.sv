

module TopModule (
  input clk,
  input in,
  input areset,
  output out
);

reg state;

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 1'b1; // Reset to state B
  end else begin
    case (state)
      2'b00: begin // State A
        if (in == 1'b0) begin
          state <= 2'b01; // Go to state B
        end else begin
          state <= 2'b00; // Stay in state A
        end
      end
      2'b01: begin // State B
        if (in == 1'b0) begin
          state <= 2'b00; // Go to state A
        end else begin
          state <= 2'b01; // Stay in state B
        end
      end
    endcase
  end
end

always @(state) begin
  case (state)
    2'b00: out = 1'b0; // State A output
    2'b01: out = 1'b1; // State B output
  endcase
end

endmodule

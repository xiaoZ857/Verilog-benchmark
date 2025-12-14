
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
`timescale 1ns / 1ps

always @(posedge clk or negedge areset) begin
    if (areset) begin
        out <= 1'b0; // Reset to state A when areset is high
    end else begin
        case (state)
            1'b0: begin // State A
                if (in) state <= 1'b1; // Transition to state B
                out <= 1'b0;
            end
            1'b1: begin // State B
                if (!in) state <= 1'b0; // Transition to state A
                out <= 1'b0;
            end
            2'b00: begin // State C
                if (in) state <= 2'b01; // Transition to state D
                out <= 1'b0;
            end
            2'b01: begin // State D
                if (!in) state <= 2'b00; // Transition to state C
                out <= 1'b1; // Output depends on current state D
            endcase
    end
end

endmodule

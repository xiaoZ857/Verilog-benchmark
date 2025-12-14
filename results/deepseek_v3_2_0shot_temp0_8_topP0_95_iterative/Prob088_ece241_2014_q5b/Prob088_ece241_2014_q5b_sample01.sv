
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
// State register with one-hot encoding
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // State A is active (one-hot)
    end else begin
        case (state)
            2'b01: // State A
                if (x) begin
                    state <= 2'b10; // Transition to state B
                end
                // If x=0, stay in state A (implicit)
            2'b10: // State B
                state <= 2'b10; // Always stay in B
            default: // Should not happen, but reset to A if it does
                state <= 2'b01;
        endcase
    end
end

// Mealy output logic: z depends on current state and input x
assign z = (state == 2'b01 && x) || (state == 2'b10 && ~x);

endmodule

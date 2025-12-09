

module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

reg state_machine = 0; // Initial state is OFF (0)
always @(posedge clk or negedge areset) begin
    if (areset) begin
        state_machine <= 0; // Reset to OFF state
    end else begin
        case (state_machine)
            0: begin
                if (j) state_machine <= 1; // Transition to ON state when j=1
            end,
            1: begin
                if (!k) state_machine <= 1; // Stay in ON state when k=0
                else state_machine <= 0; // Transition to OFF state when k=1
            end
        endcase
    end
end
assign out = state_machine; // Output is the current state of the state machine

endmodule

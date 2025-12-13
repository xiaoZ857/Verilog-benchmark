
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
always @(posedge clk) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end else begin
        case(state)
            2'b00: // State A
                if (!x) begin
                    state <= 2'b01; // Transition to B
                end
            2'b01: // State B
                if (x) begin
                    state <= 2'b10; // Transition to C
                end else begin
                    state <= 2'b00; // Stay in state A
                end
            2'b10: // State C
                if (!x) begin
                    state <= 2'b01; // Transition back to B
                end
        endcase
    end
end

assign z = {state[1], state[0]}; // Output signal in one-hot encoding

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found


module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
always @(posedge clk or negedge areset) begin
    if (areset) begin
        state <= 2'b0; // Reset to state A
    end else if (state == 2'b1) begin // State B
        if (x == 1'b1) begin
            state <= 2'b0; // Transition back to state A
            z <= 1'b0; // Output z = 0
        end else begin
            state <= 2'b1; // Stay in state B
            z <= 1'b1; // Output z = 1
        end
    end else begin // State A
        if (x == 1'b1) begin
            state <= 2'b1; // Transition to state B
            z <= 1'b1; // Output z = 1
        end else begin
            state <= 2'b0; // Stay in state A
            z <= 1'b0; // Output z = 0
        end
    end
end

initial begin
    state <= 2'b0; // Initialize state to A at time 0
end

assign z = (state == 2'b1) ? 1'b1 : 1'b0; // Assign output z based on current state

// VERILOG-EVAL: endmodule not found

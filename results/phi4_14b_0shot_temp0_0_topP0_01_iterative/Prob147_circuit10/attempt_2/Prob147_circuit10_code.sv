
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
reg q_reg; // Register to hold the current state of q

always @(posedge clk) begin
    reg q_next; // Next state for q

    // Determine next state of q based on current inputs and state
    if (a == 1 && b == 0) begin
        q_next = ~q_reg; // Toggle q
    end else if (a == 0 && b == 1) begin
        q_next = 1'b1; // Set q to 1
    end else if (a == 1 && b == 1) begin
        q_next = ~q_reg; // Toggle q
    end else begin
        q_next = q_reg; // If a == 0 and b == 0, do nothing (q remains unchanged)
    end

    // Update the register holding q's value
    q_reg <= q_next;

    // Update state only if q has changed
    if (q_reg != q_next) begin
        state <= q_next;
    end else begin
        state <= q_reg; // Maintain current state if no change in q
    end
end

// Output assignment
assign q = q_reg;

endmodule

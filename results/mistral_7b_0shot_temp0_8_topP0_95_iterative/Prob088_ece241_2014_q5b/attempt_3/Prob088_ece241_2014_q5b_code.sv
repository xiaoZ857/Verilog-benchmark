
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);
always @(posedge clk or negedge areset) begin
    if (areset) state <= 2'b00; // Reset to state A
    else case(state)
        2'b00: begin
            if (x) state <= 2'b01; // Transition to state B when x is high
        end,
        2'b01: begin
            z <= !x; // Output the complement of x in state B
            if (!x) state <= 2'b00; // Reset to state A when x becomes low
        end;
end

assign z = (state == 2'b00)? 1'b0 : 1'b1; // Assign the final output value based on the current state

endmodule


module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= 0; // Reset to OFF state
    else if (current_state == 0) begin
        if (j)
            current_state <= 1; // Transition from OFF to ON when j=1
    end
    else if (current_state == 1) begin
        if (k)
            current_state <= 0; // Transition from ON to OFF when k=1
        else
            current_state <= 1; // Stay in ON state when k=0
    end
end

assign out = current_state; // Assign the output based on the current state


// VERILOG-EVAL: endmodule not found

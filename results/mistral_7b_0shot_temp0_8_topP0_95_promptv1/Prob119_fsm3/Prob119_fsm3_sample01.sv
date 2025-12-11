
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
 ```verilog
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1'b0; // Reset to initial state A upon positive edge of areset
    else if (state == 1'b0 && in == 0)
        state <= 1'b1; // Transition from A to B when input is 0
    else if (state == 1'b0 && in == 1)
        state <= 1'b0; // Stay in state A when input is 1
    else if (state == 1'b1 && in == 0)
        state <= 1'b2; // Transition from B to C when input is 0
    else if (state == 1'b1 && in == 1)
        state <= 1'b1; // Stay in state B when input is 1
    else if (state == 1'b2 && in == 0)
        state <= 1'b3; // Transition from C to A when input is 0
    else if (state == 1'b2 && in == 1)
        state <= 1'b0; // Transition from C to B when input is 1, then B goes back to A after one cycle
    else if (state == 1'b3 && in == 0)
        state <= 1'b2; // Transition from D to C when input is 0
    else if (state == 1'b3 && in == 1)
        state <= 1'b1; // Transition from D to B when input is 1
end

assign out = state == 1'b1;

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found

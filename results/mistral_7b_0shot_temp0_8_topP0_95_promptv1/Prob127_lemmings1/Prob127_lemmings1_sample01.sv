
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
 ```verilog
always @(posedge clk or negedge areset) begin
    if (!areset)
        state <= LEFT;
    else if (bump_left && state === RIGHT)
        state <= LEFT;
    else if (bump_right && state === LEFT)
        state <= RIGHT;
end

assign walk_left = state === LEFT;
assign walk_right = state === RIGHT;

enum {LEFT, RIGHT};
reg [1:0] state;

Verification checklist:
[ ] Code ends with `endmodule` (not included in the output)
[ ] All wire outputs use `assign` keyword (used assign for both walk_left and walk_right)
[ ] All reg outputs are assigned in always blocks (state is declared as a reg and assigned in the always block)
[ ] Only declared signals are used (only state and internal signal are used)
[ ] Blocking/non-blocking assignments are correct (used blocking assignment for state assignment, since it's sequential logic with clk)

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found

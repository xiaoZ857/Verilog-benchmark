
module TopModule (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output walk_left,
  output walk_right
);
// Moore State Machine for Lemmings
module LemmingsFSM (
    // Clock and Reset signals
    input clk,
    input areset,

    // Bump inputs
    input bump_left,
    input bump_right,

    // Output signals
    output walk_left,
    output walk_right
);

    // Define the states of the FSM
    parameter [1:0] state = 2'b00; // Initial state is walking left

    // Define the next state for each possible current state and input combination
    localparam [1:0] nextState_left = {state[1], ~state[0]};
    localparam [1:0] nextState_right = {state[0], ~state[1]};

    // Define the output signals based on the current state
    localparam walk_left_out = (state == 2'b00) || (bump_left && !bump_right);
    localparam walk_right_out = (state == 2'b01) || (bump_right && !bump_left);

    // Asynchronous reset
    always @(posedge areset) state <= 2'b00;

    // Clocked next state logic
    always @(posedge clk) begin
        if (!areset) state <= nextState_left;
        else if (state == 2'b00 && bump_right) state <= nextState_right;
        else if (state == 2'b01 && bump_left) state <= nextState_right;
        else if (bump_left && bump_right) state <= nextState_right;
        else state <= nextState_left;
    end

    // Output signals
    assign walk_left = walk_left_out;
    assign walk_right = walk_right_out;

endmodule

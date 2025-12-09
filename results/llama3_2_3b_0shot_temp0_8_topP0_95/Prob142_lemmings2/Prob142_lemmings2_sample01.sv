
module TopModule(
  input clk, // Positive edge triggered clock signal
  input areset, // Positive edge triggered asynchronous reset
  input bump_left, // Input from left side of the world
  input bump_right, // Input from right side of the world
  input ground, // Ground state (0 means falling, 1 means not falling)
  output walk_left, // Output signal to walk left
  output walk_right, // Output signal to walk right
  output aaah // Output signal for "aaah!" sound
);

  reg [1:0] state; // Current state of the Lemming
  reg fall_state; // State when falling (only 1)

wire [1:0] left_bump, right_bump; // Signals from bump_left and bump_right

// Initialize states
assign left_bump = ~bump_left;
assign right_bump = ~bump_right;

// Moore machine logic
always @(posedge clk) begin
  if(areset) begin
    state <= 0; // Reset to walking left
    fall_state <= 0; // Reset fall state
  end else begin
    if((state == 1 && !ground) || (state == 2 && ground)) begin // Falling from the ground
      state <= 2;
    end else if(bump_left) begin
      state <= (state==0)? 1: 0;
    end else if(bump_right) begin
      state <= (state==1)? 2: 1;
    end else if(!left_bump && !right_bump) begin // No bump and not falling, stay in current direction
      state <= state;
    end else begin // Bumped either left or right (or both), switch direction
      fall_state <= 0; // Reset fall state
      state <= state == 1? 2: 1;
    end
  end
end

assign walk_left = ~(state==1);
assign walk_right = ~(state==0);

assign aaah = (fall_state == 1); // Produce "aaah!" when falling


endmodule

// VERILOG-EVAL: errant inclusion of module definition


module TopModule (
  input clk,
  input reset,
  input w,
  output z
);
// State Machine Module Implementation

module StateMachine (
  // Inputs
  input clk,
  input reset,
  input w,

  // Outputs
  output [3:0] z
);

reg [3:0] state, nextState;
reg [3:0] prev_state;

initial
begin
  // Initialize states for each initial value of A
  state <= 4'd0;  // A(0) is 0
end

always @(posedge clk)
begin
  if (reset)
    begin
      state <= 4'd0;
      nextState <= 4'd0;
    end
  else
  begin
    // State Machine Logic
    case(state)
      4'd0:
        if (w == 1'b0) 
          nextState = 4'd0; 
        else
          nextState = 4'd1;
      4'd1:
        nextState = 4'd2;
      4'd2:
        if (w == 1'b0)
          nextState = 4'd3;
        else
          nextState = 4'd1;
      default:
        nextState = 4'd0; // Default state when any other value of A occurs.
    endcase

    prev_state <= state;

    state <= nextState;
  end
end

// Output Logic
assign z = state;

// VERILOG-EVAL: endmodule not found

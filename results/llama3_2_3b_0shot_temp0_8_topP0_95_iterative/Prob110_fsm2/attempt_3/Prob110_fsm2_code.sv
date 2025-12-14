
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
reg [1:0] internal_state = 2'b00; // Internal state register

// Initialize the state to OFF on clock rising edge and reset on active-high reset pulse
always @(posedge clk or areset) begin
    if (areset) {
        internal_state <= 2'b00;
    } else if (clk == 1'b1) {  // Clock rising edge
        case(internal_state)
            2'b00:      internal_state = 2'b00; 
            2'b01:      internal_state = 2'b10; // Update value for j=1 and k=0 transition
            2'b10:      internal_state = 2'b11; 
            2'b11:      internal_state = 2'b01; // Update value for k=1 and j=0 transitions
        endcase;
    }
end

// Update the output on the clock rising edge
assign out = (internal_state == 2'b00) ? 0 : 1;

// Edge-triggered state transitions based on j and k inputs
always @(posedge clk or posedge j or posedge k) begin
    if ((~ internal_state[1] && j) || (~ internal_state[0] && ~ internal_state[1] && k)) {
        internal_state = 2'b01; // Transition from OFF to ON on j=1 and k=0
    } else if (internal_state == 2'b11) {
        internal_state = 2'b10; // Transition from ON to OFF on k=1
    }
end

endmodule

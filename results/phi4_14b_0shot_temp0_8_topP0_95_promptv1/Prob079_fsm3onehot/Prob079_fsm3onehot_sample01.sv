
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
assign out = state[3]; // Output logic for Moore machine (output depends on current state)

// State transition logic using one-hot encoding
always @(*) begin
    case (state)
        4'b0001: // Current state A
            if (in)
                next_state = 4'b0010; // Transition to B when in=1
            else
                next_state = 4'b0001; // Remain in A when in=0

        4'b0010: // Current state B
            if (in)
                next_state = 4'b0010; // Stay in B when in=1
            else
                next_state = 4'b0100; // Transition to C when in=0

        4'b0100: // Current state C
            if (in)
                next_state = 4'b1000; // Transition to D when in=1
            else
                next_state = 4'b0001; // Transition to A when in=0

        4'b1000: // Current state D
            if (in)
                next_state = 4'b0010; // Transition to B when in=1
            else
                next_state = 4'b0100; // Transition to C when in=0

        default:
            next_state = 4'b0001; // Default transition to state A
    endcase
end

endmodule

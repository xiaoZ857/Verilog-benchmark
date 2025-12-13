
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
always @(*) begin
    // Next state logic
    next_state[3] = (state[0] & in) | (state[2] & in) | (state[3] & ~in);  // D
    next_state[2] = (state[0] & ~in) | (state[1] & ~in) | (state[2] & in);  // C
    next_state[1] = (state[0] & in) | (state[1] & ~in);                     // B
    next_state[0] = (state[0] & ~in) | (state[2] & ~in);                    // A
end

// Output logic
assign out = state[3];  // D outputs 1, others output 0

endmodule

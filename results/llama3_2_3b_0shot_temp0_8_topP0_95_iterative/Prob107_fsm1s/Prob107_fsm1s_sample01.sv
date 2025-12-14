
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

    // Timescale directive should be placed outside of the module definition
    timescale 1 ns / 10 ns;

    reg [1:0] currentState;        // State machine state, initialized to B (B) when reset is active-high

    initial begin      // Reset the state machine on each clock rise
        if(reset == 1'b1)
            currentState = 2'b11;  // Reset state to high to ensure the state never resets
    end

always @(*) begin
    case(currentState)
        2'b00: out = 1'b0;       // Output is low when in STATE_A
        2'b01: out = 1'b0;
        2'b10: out = 1'b1;       // Output is high when in STATE_B
        2'b11: out = 1'b1;
    endcase
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

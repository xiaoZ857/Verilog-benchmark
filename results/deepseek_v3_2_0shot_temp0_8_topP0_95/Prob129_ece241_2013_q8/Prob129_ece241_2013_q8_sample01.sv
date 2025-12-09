
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
// Define states using localparam
localparam S0 = 2'b00, // No valid sequence
           S1 = 2'b01, // Got '1'
           S2 = 2'b10; // Got "10"

// State registers
reg [1:0] state, next_state;

// State transition logic (combinational)
always @(*) begin
    case (state)
        S0: next_state = x ? S1 : S0; // If x=1, move to S1; else stay in S0
        S1: next_state = x ? S1 : S2; // If x=0, move to S2; else stay in S1 (overlapping detection)
        S2: next_state = x ? S1 : S0; // If x=1, move to S1; else go to S0
        default: next_state = S0;
    endcase
end

// State update and asynchronous reset (negative edge triggered)
always @(negedge aresetn or posedge clk) begin
    if (!aresetn) // Asynchronous reset on negative edge of aresetn
        state <= S0;
    else
        state <= next_state;
end

// Output logic (Mealy: depends on current state and input)
always @(*) begin
    case (state)
        S2: z = x ? 1'b1 : 1'b0; // In S2, if x=1, output 1 (sequence "101" detected)
        default: z = 1'b0; // Otherwise output 0
    endcase
end

endmodule

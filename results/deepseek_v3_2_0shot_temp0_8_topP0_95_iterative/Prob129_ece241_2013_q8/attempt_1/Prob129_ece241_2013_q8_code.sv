
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
// Define states using localparam
localparam S0 = 2'b00, // initial state, no matching bits
           S1 = 2'b01, // first '1' detected
           S2 = 2'b10; // "10" detected

reg [1:0] current_state, next_state;

// State register with negative edge triggered asynchronous reset
always @(negedge clk or negedge aresetn) begin
    if (!aresetn)
        current_state <= S0;
    else
        current_state <= next_state;
end

// Next state logic (combinational)
always @(*) begin
    case (current_state)
        S0: next_state = x ? S1 : S0;
        S1: next_state = x ? S1 : S2;
        S2: next_state = x ? S1 : S0;
        default: next_state = S0;
    endcase
end

// Output logic (Mealy: depends on current_state and input x)
always @(*) begin
    case (current_state)
        S2: z = x ? 1'b1 : 1'b0; // output 1 only if we are in S2 and x is 1
        default: z = 1'b0;
    endcase
end

endmodule

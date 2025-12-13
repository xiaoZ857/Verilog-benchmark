
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
// Define states using localparam
localparam S0 = 2'b00, // initial/reset state
           S1 = 2'b01, // got '1'
           S2 = 2'b10; // got "10"

// State register
reg [1:0] state, next_state;

// State transition logic (combinational)
always @(*) begin
    case (state)
        S0: next_state = x ? S1 : S0;
        S1: next_state = x ? S1 : S2;
        S2: next_state = x ? S1 : S0;
        default: next_state = S0;
    endcase
end

// State update and asynchronous reset (negative edge triggered)
always @(negedge aresetn or posedge clk) begin
    if (!aresetn)
        state <= S0;
    else
        state <= next_state;
end

// Output logic (Mealy: depends on state and input)
always @(*) begin
    case (state)
        S2: z = x; // output 1 only if we are in S2 and current input is 1
        default: z = 1'b0;
    endcase
end

endmodule

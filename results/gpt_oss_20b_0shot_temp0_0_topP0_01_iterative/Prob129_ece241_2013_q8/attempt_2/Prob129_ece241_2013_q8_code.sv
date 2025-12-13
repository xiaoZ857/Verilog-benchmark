
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);
// State encoding
parameter IDLE = 2'b00,
          S1   = 2'b01,
          S10  = 2'b10;

// State registers
reg [1:0] state, next_state;

// Asynchronous active‑low reset (negative edge) and synchronous state update
always @(negedge aresetn or posedge clk) begin
    if (!aresetn)
        state <= IDLE;
    else
        state <= next_state;
end

// Combinational logic for next state and output
always @(*) begin
    // Default assignments
    next_state = state;
    z          = 1'b0;

    case (state)
        IDLE: begin
            if (x)
                next_state = S1;
            else
                next_state = IDLE;
        end

        S1: begin
            if (x)
                next_state = S1;   // stay in S1 for overlapping '1'
            else
                next_state = S10;  // seen '10'
        end

        S10: begin
            if (x) begin
                next_state = S1;   // overlapping: last '1' becomes start of new sequence
                z          = 1'b1; // sequence '101' detected
            end else begin
                next_state = IDLE; // no match, reset to IDLE
            end
       

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found


module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
// State encoding
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// Current state register
reg state;

// Next state combinational signal
reg next_state;

// State register – synchronous update, asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= STATE_B;
    else
        state <= next_state;
end

// Next state logic
always @* begin
    case (state)
        STATE_A: begin
            if (in == 1'b0)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        STATE_B: begin
            if (in == 1'b0)
                next_state = STATE_A;
            else
                next_state = STATE_B;
        end
        default: next_state = STATE_B;
    endcase
end

// Output logic (Moore output)
always @* begin
    out = state;
end

endmodule

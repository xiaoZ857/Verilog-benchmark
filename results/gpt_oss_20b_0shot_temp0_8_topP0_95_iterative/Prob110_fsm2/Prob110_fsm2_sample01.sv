
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
    // State encoding
    localparam OFF = 1'b0;
    localparam ON  = 1'b1;

    // State register and next‑state variable
    reg state;
    reg next_state;

    // Combinational next‑state logic
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON : next_state = k ? OFF : ON;
            default: next_state = OFF;  // safety default
        endcase
    end

    // Sequential state update with async reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Moore output (depends only on state)
    assign out = state;

endmodule

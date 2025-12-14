
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);
    // State encoding (2‑bit)
    localparam  A = 2'b00,
                B = 2'b01,
                C = 2'b10,
                D = 2'b11;

    // State registers
    reg  [1:0] state, next_state;

    // State register: synchronous update, asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;                 // reset to state A
        else
            state <= next_state;        // update to next state
    end

    // Next‑state logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;   // A → A (in=0) / B (in=1)
            B: next_state = in ? B : C;   // B → C (in=0) / B (in=1)
            C: next_state = in ? D : A;   // C → A (in=0) / D (in=1)
            D: next_state = in ? B : C;   // D → C (in=0) / B (in=1)
            default: next_state = A;      // safety default
        endcase
    end

    // Output logic (Moore)
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule

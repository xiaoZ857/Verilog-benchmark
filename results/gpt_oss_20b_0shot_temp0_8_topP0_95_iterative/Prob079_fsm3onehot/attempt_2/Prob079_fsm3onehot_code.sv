
module TopModule (
  input in,
  input [3:0] state,
  output reg [3:0] next_state,
  output out
);
    // Output logic – Moore output depends only on the current state
    assign out = state[3];

    // State‑transition logic – combinational
    always @(*) begin
        // Default assignment (synthesis safety)
        next_state = 4'b0000;

        case (state)
            // State A : 4'b0001
            4'b0001: next_state = in ? 4'b0010 : 4'b0001;   // in=1 → B,  in=0 → A

            // State B : 4'b0010
            4'b0010: next_state = in ? 4'b0010 : 4'b0100;   // in=1 → B,  in=0 → C

            // State C : 4'b0100
            4'b0100: next_state = in ? 4'b1000 : 4'b0001;   // in=1 → D,  in=0 → A

            // State D : 4'b1000
            4'b1000: next_state = in ? 4'b0010 : 4'b0100;   // in=1 → B,  in=0 → C

            // Undefined state – stay idle
            default: next_state = 4'b0000;
        endcase
    end
endmodule

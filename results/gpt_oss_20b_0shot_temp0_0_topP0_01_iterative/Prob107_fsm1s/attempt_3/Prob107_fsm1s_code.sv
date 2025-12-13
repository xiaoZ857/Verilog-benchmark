
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
  // State encoding
  localparam B = 1'b0;
  localparam A = 1'b1;

  logic state, next_state;

  // State register (synchronous reset)
  always_ff @(posedge clk) begin
    if (reset)
      state <= B;
    else
      state <= next_state;
  end

  // Next‑state logic
  always_comb begin
    case (state)
      B: next_state = in ? B : A;   // B --in=0--> A, B --in=1--> B
      A: next_state = in ? A : B;   // A --in=0--> B, A --in=1--> A
      default: next_state = B;      // safety default
    endcase
  end

  // Output logic (Moore)
  assign out = (state == B) ? 1'b1 : 1'b0;

endmodule

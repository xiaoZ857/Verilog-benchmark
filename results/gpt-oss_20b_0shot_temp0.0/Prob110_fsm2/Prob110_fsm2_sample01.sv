

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

  // State register
  reg state;
  reg next_state;

  // Asynchronous reset and state update
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= OFF;
    else
      state <= next_state;
  end

  // Next state logic
  always @(*) begin
    case (state)
      OFF: next_state = j ? ON : OFF;
      ON:  next_state = k ? OFF : ON;
      default: next_state = OFF; // safety
    endcase
  end

  // Moore output
  assign out = state;
endmodule

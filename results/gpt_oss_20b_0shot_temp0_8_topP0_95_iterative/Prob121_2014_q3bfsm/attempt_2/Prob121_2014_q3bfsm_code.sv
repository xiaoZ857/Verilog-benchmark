
module TopModule (
  input clk,
  input reset,
  input x,
  output reg z
);
  // State register
  reg [2:0] y;          // present state
  wire [2:0] next_state;

  // Next‑state logic (combinational)
  always @(*) begin
    case (y)
      3'b000: next_state = x ? 3'b001 : 3'b000;
      3'b001: next_state = x ? 3'b100 : 3'b001;
      3'b010: next_state = x ? 3'b001 : 3'b010;
      3'b011: next_state = x ? 3'b010 : 3'b001;
      3'b100: next_state = x ? 3'b100 : 3'b011;
      default: next_state = 3'b000; // safety default
    endcase
  end

  // State register update (synchronous reset)
  always @(posedge clk) begin
    if (reset)
      y <= 3'b000;          // synchronous active‑high reset
    else
      y <= next_state;
  end

  // Output logic (combinational)
  always @(*) begin
    case (y)
      3'b011,
      3'b100: z = 1'b1;
      default: z = 1'b0;
    endcase
  end
endmodule


module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
  // State encoding: A=00, B=01, C=10, D=11
  reg [1:0] state, next_state;
  
  always @(posedge clk) begin
    if (reset) state <= 2'b00; // Reset to state A
    else state <= next_state;
  end
  
  always @(*) begin
    case (state)
      2'b00: next_state = in ? 2'b01 : 2'b00; // A -> B if in=1, else A
      2'b01: next_state = in ? 2'b01 : 2'b10; // B -> B if in=1, else C
      2'b10: next_state = in ? 2'b11 : 2'b00; // C -> D if in=1, else A
      2'b11: next_state = in ? 2'b01 : 2'b10; // D -> B if in=1, else C
      default: next_state = 2'b00;
    endcase
  end
  
  assign out = (state == 2'b11); // Output 1 only in state D
endmodule

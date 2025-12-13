
module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);
always_comb begin
  case (state)
    2'b00: // State A
      if(in)
        next_state <= 2'b01; // B
      else
        next_state <= 2'b00; // A
      out <= 0;

    2'b01: // State B
      if(in)
        next_state <= 2'b10; // C
      else
        next_state <= 2'b01; // B
      out <= 0;

    2'b10: // State C
      if(!in)
        next_state <= 2'b11; // D
      else
        next_state <= 2'b10; // C
      out <= 0;

    2'b11: // State D
      if(in)
        next_state <= 2'b10; // C
      else
        next_state <= 2'b01; // B
      out <= 1;
  endcase
end

endmodule

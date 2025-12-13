
module TopModule (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output out
);

always @(*) begin
  case (state)
    2'b00: begin  // State A
      if (in == 0)
        next_state = 2'b00;  // A
      else
        next_state = 2'b01;  // B
    end
    2'b01: begin  // State B
      if (in == 0)
        next_state = 2'b10;  // C
      else
        next_state = 2'b01;  // B
    end
    2'b10: begin  // State C
      if (in == 0)
        next_state = 2'b00;  // A
      else
        next_state = 2'b11;  // D
    end
    2'b11: begin  // State D
      if (in == 0)
        next_state = 2'b10;  // C
      else
        next_state = 2'b01;  // B
    end
    default: begin
      next_state = 2'b00;
    end
  endcase
end

// Output logic for Moore machine (output depends only on current state)
assign out = (state == 2'b11) ? 1 : 0;

endmodule

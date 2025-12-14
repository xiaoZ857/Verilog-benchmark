
module TopModule (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);
always @(posedge w) begin
  tmp_state <= state; // Store current state temporarily

  case (y) // Check current state and determine next state
    // A state
    6'b000001 : if (tmp_state != 4'b00000) state <= 4'b00000; // A -> A or B
    6'b000010 : if (tmp_state == 4'b00000) state <= 4'b00001; // A -> B
    // B state
    6'b000100 : if (tmp_state != 4'b00001) state <= 4'b00010; // B -> D or C
    6'b001000 : if (tmp_state == 4'b00001) state <= 4'b00100; // B -> C
    // C state
    6'b010000 : if (tmp_state != 4'b00100) state <= 4'b01000; // C -> D or E
    6'b010001 : if (tmp_state == 4'b00100) state <= 4'b01001; // C -> F
    // D state
    6'b100000 : if ((tmp_state != 4'b00101) && (tmp_state != 4'b01000)) state <= 4'b10000; // D -> F or E
    6'b100001 : if (tmp_state == 4'b00101) state <= 4'b10001; // D -> F
    // E and F states
    6'b010010 : if ((tmp_state != 4'b10001) && (tmp_state != 4'b100000) && (tmp_state != 4'b010000)) state <= 4'b10000; // Any other state leads to A
    default   : state <= 4'b00000; // Any other input leads to A
  endcase
end

assign Y1 = state[1]; // Y1 is the output of state flip-flop y[1]
assign Y3 = state[3]; // Y3 is the output of state flip-flop y[3]

endmodule

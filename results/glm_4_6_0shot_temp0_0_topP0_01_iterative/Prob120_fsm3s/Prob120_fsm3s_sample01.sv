
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);
// State encoding
localparam [1:0] STATE_A = 2'b00;
localparam [1:0] STATE_B = 2'b01;
localparam [1:0] STATE_C = 2'b10;
localparam [1:0] STATE_D = 2'b11;

reg [1:0] current_state, next_state;

// State register
always @(posedge clk) begin
  if (reset) begin
    current_state <= STATE_A;
  end else begin
    current_state <= next_state;
  end
end

// Next state logic
always @(*) begin
  case (current_state)
    STATE_A: begin
      if (in) next_state = STATE_B;
      else next_state = STATE_A;
    end
    STATE_B: begin
      if (in) next_state = STATE_B;
      else next_state = STATE_C;
    end
    STATE_C: begin
      if (in) next_state = STATE_D;
      else next_state = STATE_A;
    end
    STATE_D: begin
      if (in) next_state = STATE_B;
      else next_state = STATE_C;
    end
    default: next_state = STATE_A;
  endcase
end

// Output logic (Moore machine - output depends only on current state)
assign out = (current_state == STATE_D);

endmodule

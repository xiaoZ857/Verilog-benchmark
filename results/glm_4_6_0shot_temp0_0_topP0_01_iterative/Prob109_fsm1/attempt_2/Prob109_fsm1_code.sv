
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state, next_state;

// State transition logic
always @(*) begin
  case (state)
    A: begin
      if (in) next_state = A;
      else next_state = B;
    end
    B: begin
      if (in) next_state = B;
      else next_state = A;
    end
    default: next_state = B;
  endcase
end

// State register with asynchronous reset
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= B;
  end else begin
    state <= next_state;
  end
end

// Output logic (Moore machine - output depends only on state)
assign out = (state == B);

endmodule

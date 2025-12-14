
module TopModule (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
// State encoding
parameter OFF = 1'b0;
parameter ON = 1'b1;

reg state, next_state;

// State register
always @(posedge clk) begin
  if (reset) begin
    state <= OFF;
  end else begin
    state <= next_state;
  end
end

// Next state logic
always @(*) begin
  case (state)
    OFF: begin
      if (j) begin
        next_state = ON;
      end else begin
        next_state = OFF;
      end
    end
    ON: begin
      if (k) begin
        next_state = OFF;
      end else begin
        next_state = ON;
      end
    end
    default: next_state = OFF;
  endcase
end

// Output logic (Moore machine - output depends only on state)
assign out = state;

endmodule

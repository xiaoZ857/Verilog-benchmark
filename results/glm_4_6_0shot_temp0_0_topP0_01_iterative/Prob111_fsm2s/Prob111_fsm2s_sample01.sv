
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

reg state_reg, next_state;

// State register
always @(posedge clk) begin
  if (reset) begin
    state_reg <= OFF;
  end else begin
    state_reg <= next_state;
  end
end

// Next state logic
always @(*) begin
  case (state_reg)
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

// Output logic (Moore machine)
assign out = state_reg;

endmodule

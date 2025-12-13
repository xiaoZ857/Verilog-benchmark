
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

reg state;
reg next_state;
reg z;

// State transition logic
always @(*) begin
  case (state)
    S0: begin
      if (x == 1'b0) begin
        next_state = S0;
      end else begin
        next_state = S1;
      end
    end
    S1: begin
      next_state = S1;
    end
  endcase
end

// Output logic (Moore machine)
always @(*) begin
  case (state)
    S0: z = x;
    S1: z = ~x;
  endcase
end

// Sequential logic
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= S0;
  end else begin
    state <= next_state;
  end
end

endmodule

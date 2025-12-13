
module TopModule (
  input clk,
  input in,
  input reset,
  output out
);

// State encoding
parameter A = 1'b0;
parameter B = 1'b1;

reg current_state, next_state;

// State register
always @(posedge clk) begin
  if (reset) begin
    current_state <= B;
  end else begin
    current_state <= next_state;
  end
end

// Next state logic
always @(*) begin
  case (current_state)
    A: begin
      if (in) begin
        next_state = A;
      end else begin
        next_state = B;
      end
    end
    B: begin
      if (in) begin
        next_state = B;
      end else begin
        next_state = A;
      end
    end
    default: next_state = B;
  endcase
end

// Output logic (Moore machine)
assign out = (current_state == B);

endmodule

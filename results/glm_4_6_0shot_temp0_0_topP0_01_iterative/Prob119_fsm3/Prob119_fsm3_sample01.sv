
module TopModule (
  input clk,
  input in,
  input areset,
  output out
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
  case (state)
    A: begin
      if (in) next_state = B;
      else next_state = A;
    end
    B: begin
      if (in) next_state = B;
      else next_state = C;
    end
    C: begin
      if (in) next_state = D;
      else next_state = A;
    end
    D: begin
      if (in) next_state = B;
      else next_state = C;
    end
    default: next_state = A;
  endcase
end

// State register with asynchronous reset
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= A;
  end else begin
    state <= next_state;
  end
end

// Output logic (Moore machine)
assign out = (state == D) ? 1'b1 : 1'b0;

endmodule

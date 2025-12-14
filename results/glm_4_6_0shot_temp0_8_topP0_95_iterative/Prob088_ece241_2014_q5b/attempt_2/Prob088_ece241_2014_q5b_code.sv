
module TopModule (
  input clk,
  input areset,
  input x,
  output z
);

reg [1:0] state;
reg [1:0] next_state;

// State encoding for one-hot
parameter A = 2'b01;
parameter B = 2'b10;

// State register with asynchronous reset
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= A;
  end else begin
    state <= next_state;
  end
end

// Next state logic and output (Mealy machine)
always @(*) begin
  // Default assignments
  next_state = state;
  z = 1'b0;
  
  case (state)
    A: begin
      if (x == 0) begin
        next_state = A;
        z = 0;
      end else begin  // x == 1
        next_state = B;
        z = 1;
      end
    end
    B: begin
      if (x == 0) begin
        next_state = B;
        z = 1;
      end else begin  // x == 1
        next_state = B;
        z = 0;
      end
    end
    default: begin
      next_state = A;
      z = 0;
    end
  endcase
end

endmodule

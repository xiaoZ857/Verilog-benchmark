
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

// State encoding with 3 states
parameter S0 = 2'b00,  // Initial state, expecting '1'
         S1 = 2'b01,  // Received '1', expecting '0'  
         S2 = 2'b10;  // Received '10', expecting '1'

reg [1:0] state, next_state;

// State transition logic
always @(*) begin
  next_state = state;
  z = 1'b0;
  
  case (state)
    S0: begin
      if (x) begin
        next_state = S1;
      end
    end
    
    S1: begin
      if (x) begin
        next_state = S1;  // Stay in S1 for consecutive '1's
      end else begin
        next_state = S2;
      end
    end
    
    S2: begin
      if (x) begin
        z = 1'b1;  // Mealy output: sequence "101" detected
        next_state = S1;  // Start new sequence with this '1'
      end else begin
        next_state = S0;
      end
    end
  endcase
end

// State register with asynchronous reset
always @(posedge clk or negedge aresetn) begin
  if (!aresetn) begin
    state <= S0;
  end else begin
    state <= next_state;
  end
end

endmodule

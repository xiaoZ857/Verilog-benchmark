
module TopModule (
  input clk,
  input aresetn,
  input x,
  output reg z
);

// State encoding
localparam [1:0] S_A = 2'b00,  // Initial state
                  S_B = 2'b01,  // "1" detected
                  S_C = 2'b10;  // "10" detected

reg [1:0] state, next_state;

// State transition logic
always @(posedge clk or negedge aresetn) begin
  if (!aresetn) begin
    state <= S_A;
  end else begin
    state <= next_state;
  end
end

// Next state and output logic (Mealy machine)
always @(*) begin
  // Default values
  next_state = state;
  z = 1'b0;
  
  case (state)
    S_A: begin
      if (x) begin
        next_state = S_B;
      end
    end
    
    S_B: begin
      if (x) begin
        next_state = S_B;  // Stay in B for overlapping
      end else begin
        next_state = S_C;
      end
    end
    
    S_C: begin
      if (x) begin
        next_state = S_B;  // Go to B for overlapping
        z = 1'b1;          // Output 1 when "101" detected
      end else begin
        next_state = S_A;
      end
    end
  endcase
end

endmodule

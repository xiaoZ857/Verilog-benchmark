
module TopModule (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

// State encoding
parameter A = 4'd0;  // Reset state
parameter B = 4'd1;  // Set f = 1 for one cycle
parameter C = 4'd2;  // Waiting for x = 1 (first of sequence)
parameter D = 4'd3;  // Waiting for x = 0 (second of sequence)
parameter E = 4'd4;  // Waiting for x = 1 (third of sequence)
parameter F = 4'd5;  // g = 1, monitoring y (first cycle)
parameter G = 4'd6;  // g = 1, monitoring y (second cycle)
parameter H = 4'd7;  // g = 1 permanently
parameter I = 4'd8;  // g = 0 permanently

reg [3:0] current_state, next_state;
reg reset_deasserted;  // Flag to track reset de-assertion

// State register with synchronous reset
always @(posedge clk) begin
  if (!resetn) begin
    current_state <= A;
    reset_deasserted <= 0;
  end else begin
    current_state <= next_state;
    if (!reset_deasserted) begin
      reset_deasserted <= 1;
    end
  end
end

// Next state logic
always @(*) begin
  case (current_state)
    A: begin
      // Transition to B on first clock edge after reset de-assertion
      if (resetn && reset_deasserted)
        next_state = B;
      else
        next_state = A;
    end
    
    B: begin
      next_state = C;
    end
    
    C: begin
      if (x == 1)
        next_state = D;
      else
        next_state = C;
    end
    
    D: begin
      if (x == 0)
        next_state = E;
      else if (x == 1)
        next_state = C;  // Restart sequence
      else
        next_state = D;
    end
    
    E: begin
      if (x == 1)
        next_state = F;  // Sequence complete, set g = 1
      else if (x == 0)
        next_state = C;  // Restart sequence
      else
        next_state = E;
    end
    
    F: begin
      if (y == 1)
        next_state = H;  // y = 1 within one cycle, maintain g

// VERILOG-EVAL: endmodule not found

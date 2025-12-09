
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output reg start_shifting
);

  // State encoding
  typedef enum logic [2:0] {
    IDLE = 3'b000,
    S1   = 3'b001,  // 1 detected
    S11  = 3'b010,  // 11 detected
    S110 = 3'b011,  // 110 detected
    FOUND = 3'b100  // 1101 found
  } state_t;

  // Register to hold the current state
  reg [2:0] current_state, next_state;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= IDLE;
      start_shifting <= 0;  // Reset output as well when resetting
    end else begin
      current_state <= next_state;
      if (current_state == FOUND) begin
        start_shifting <= 1;
      end
    end
  end

  always_comb begin
    // Default assignments to avoid latches
    next_state = current_state;  // Stay in the same state by default
    
    case (current_state)
      IDLE: if (data == 1'b1) begin
              next_state = S1;
            end
        
      S1:   if (data == 1'b1) begin
              next_state = S11;
            end else if (data == 1'b0) begin
              next_state = IDLE;
            end
        
      S11:  if (data == 1'b0) begin
              next_state = S110;
            end else if (data == 1'b1) begin
              next_state = S11; // Stay at S11 because sequence is not broken yet
            end else begin
              next_state = IDLE;
            end
        
      S110: if (data == 1'b1) begin
              next_state = FOUND;
            end else if (data == 1'b0) begin
              next_state = S110; // Stay at S110 because sequence is not broken yet
            end else begin
              next_state = IDLE;
            end

      FOUND: begin
               next_state = FOUND;  // Remain in the found state once detected
             end
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

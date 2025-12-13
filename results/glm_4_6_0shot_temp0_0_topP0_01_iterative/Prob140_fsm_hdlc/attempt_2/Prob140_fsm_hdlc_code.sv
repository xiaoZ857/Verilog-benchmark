
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);

  // State encoding for Moore FSM
  parameter S0 = 4'd0;  // Reset state / previous input was 0
  parameter S1 = 4'd1;  // Saw 01
  parameter S2 = 4'd2;  // Saw 011
  parameter S3 = 4'd3;  // Saw 0111
  parameter S4 = 4'd4;  // Saw 01111
  parameter S5 = 4'd5;  // Saw 011111
  parameter S6 = 4'd6;  // Saw 0111110 (disc condition)
  parameter S7 = 4'd7;  // Saw 01111110 (flag condition)
  parameter S8 = 4'd8;  // Saw 7+ consecutive 1s (error condition)
  
  reg [3:0] current_state, next_state;
  
  // State transition logic
  always @(posedge clk) begin
    if (reset) begin
      current_state <= S0;
    end else begin
      current_state <= next_state;
    end
  end
  
  // Next state logic
  always @(*) begin
    case (current_state)
      S0: begin
        if (in == 1'b1) next_state = S1;
        else next_state = S0;
      end
      S1: begin
        if (in == 1'b1) next_state = S2;
        else next_state = S0;
      end
      S2: begin
        if (in == 1'b1) next_state = S3;
        else next_state = S0;
      end
      S3: begin
        if (in == 1'b1) next_state = S4;
        else next_state = S0;
      end
      S4: begin
        if (in == 

// VERILOG-EVAL: endmodule not found

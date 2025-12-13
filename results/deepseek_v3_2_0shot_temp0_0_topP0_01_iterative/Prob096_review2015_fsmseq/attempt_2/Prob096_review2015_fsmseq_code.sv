
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);
  reg [2:0] state, next_state;
  
  localparam S0 = 3'd0,
             S1 = 3'd1,
             S2 = 3'd2,
             S3 = 3'd3,
             S4 = 3'd4;
  
  // State register
  always @(posedge clk) begin
    if (reset)
      state <= S0;
    else
      state <= next_state;
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      S0: next_state = data ? S1 : S0;
      S1: next_state = data ? S2 : S0;
      S2: next_state = data ? S2 : S3;
      S3: next_state = data ? S4 : S0;
      S4: next_state = S4; // stay here forever until reset
      default: next_state = S0;
    endcase
  end
  
  // Output logic: start_shifting = 1 when in state S4
  assign start_shifting = (state == S4);

endmodule


module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State definitions - track consecutive 1s count
  localparam S0 = 3'd0,  // 0 consecutive 1s
             S1 = 3'd1,  // 1 consecutive 1
             S2 = 3'd2,  // 2 consecutive 1s
             S3 = 3'd3,  // 3 consecutive 1s
             S4 = 3'd4,  // 4 consecutive 1s
             S5 = 3'd5,  // 5 consecutive 1s - special state
             S6 = 3'd6,  // 6 consecutive 1s
             S7 = 3'd7;  // 7+ consecutive 1s (error)

  reg [2:0] state, next_state;
  reg disc_reg, flag_reg, err_reg;
  
  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= S0;
      disc_reg <= 1'b0;
      flag_reg <= 1'b0;
      err_reg <= 1'b0;
    end else begin
      state <= next_state;
      // Output logic based on current state and input
      disc_reg <= 1'b0;
      flag_reg <= 1'b0;
      err_reg <= 1'b0;
      
      // disc: after 5 consecutive 1s, next bit is 0 (discard this 0)
      if (state == S5 && in == 1'b0) disc_reg <= 1'b1;
      // flag: after 6 consecutive 1s, next bit is 0
      if (state == S6 && in == 1'b0) flag_reg <= 1'b1;
      // err: when we enter or remain in S7 (7+ consecutive 1s)
      if (next_state == S7) err_reg <= 1'b1;
    end
  end

  // Next state logic
  always @(*) begin
    case (state)
      S0: next_state = in ? S1 : S0;
      S1: next_state = in ? S2 : S0;
      S2: next_state = in ? S3 : S0;
      S3: next_state = in ? S4 : S0;
      S4: next_state = in ? S5 : S0;
      S5: begin
        // After 5 consecutive 1s:
        // - If next bit is 0: discard it (go back to S0)
        // - If next bit is 1: continue counting (go to S6)
        if (in) next_state = S6;
        else next_state = S0;
      end
      S6: begin
        // After 6 consecutive 1s:
        // - If next bit is 0: flag detected (go to S0)
        // - If next bit is 1: error (go to S7)
        if (in) next_state = S7;
        else next_state = S0;
      end
      S7: next_state = in ? S7 : S0;
      default: next_state = S0;
    endcase
  end

  // Output assignments
  assign disc = disc_reg;
  assign flag = flag_reg;
  assign err = err_reg;
endmodule


module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State encoding
  localparam S0 = 4'd0;  // Initial state, or after seeing 0
  localparam S1 = 4'd1;  // 1
  localparam S2 = 4'd2;  // 11
  localparam S3 = 4'd3;  // 111
  localparam S4 = 4'd4;  // 1111
  localparam S5 = 4'd5;  // 11111 (5 ones)
  localparam S6 = 4'd6;  // 111111 (6 ones)
  localparam S7 = 4'd7;  // 1111111 (7 ones - error)
  localparam S8 = 4'd8;  // 8+ ones (stay in error)
  
  reg [3:0] state, next_state;
  reg disc_reg, flag_reg, err_reg;
  
  // Registered outputs - asserted one cycle AFTER pattern completes
  assign disc = disc_reg;
  assign flag = flag_reg;
  assign err = err_reg;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= S0;
      disc_reg <= 1'b0;
      flag_reg <= 1'b0;
      err_reg <= 1'b0;
    end else begin
      state <= next_state;
      
      // Clear outputs unless they're being set this cycle
      disc_reg <= 1'b0;
      flag_reg <= 1'b0;
      err_reg <= 1'b0;
      
      // Set outputs based on NEXT state (Moore outputs)
      case (next_state)
        S0: begin
          // Check if we just completed a pattern
          if (state == S5 && in == 1'b0) begin
            disc_reg <= 1'b1;  // 5 ones then 0
          end else if (state == S6 && in == 1'b0) begin
            flag_reg <= 1'b1;  // 6 ones then 0
          end else if (state == S7 || state == S8) begin
            err_reg <= 1'b1;   // 7+ ones
          end
        end
        S7, S8: begin
          err_reg <= 1'b1;     // In error state
        end
      endcase
    end
  end
  
  always @(*) begin
    case (state)
      S0: next_state = in ? S1 : S0;
      S1: next_state = in ? S2 : S0;
      S2: next_state = in ? S3 : S0;
      S3: next_state = in ? S4 : S0;
      S4: next_state = in ? S5 : S0;
      S5: next_state = in ? S6 : S0;  // 5 ones: continue counting
      S6: next_state = in ? S7 : S0;  // 6 ones: continue counting
      S7: next_state = in ? S8 : S0;  // 7 ones: error, go to S8 on more 1s
      S8: next_state = in ? S8 : S0;  // 8+ ones: stay in error until 0
      default: next_state = S0;
    endcase
  end
endmodule

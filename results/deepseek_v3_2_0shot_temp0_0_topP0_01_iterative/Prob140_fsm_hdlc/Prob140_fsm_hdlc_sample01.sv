
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
  
  // Registered outputs
  assign disc = disc_reg;
  assign flag = flag_reg;
  assign err = err_reg;
  
  // Next state logic
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
  
  // Output and state update logic
  always @(posedge clk) begin
    if (reset) begin
      state <= S0;
      disc_reg <= 1'b0;
      flag_reg <= 1'b0;
      err_reg <= 1'b0;
    end else begin
      state <= next_state;
      
      // Clear outputs by default
      disc_reg <= 1'b0;
      flag_reg <= 1'b0;
      err_reg <= 1'b0;
      
      // Set outputs based on current state and input (for next cycle)
      // Outputs are asserted one cycle AFTER the pattern completes
      case (state)
        S5: begin
          if (!in) begin
            disc_reg <= 1'b1;  // 5 ones followed by 0
          end
        end
        S6: begin
          if (!in) begin
            flag_reg <= 1'b1;  // 6 ones followed by 0
          end
        end
        S7: begin
          err_reg <= 1'b1;     // 7 ones (error)
        end
        S8: begin
          err_reg <= 1'b1;     // 8+ ones (error)
        end
      endcase
    end
  end
endmodule

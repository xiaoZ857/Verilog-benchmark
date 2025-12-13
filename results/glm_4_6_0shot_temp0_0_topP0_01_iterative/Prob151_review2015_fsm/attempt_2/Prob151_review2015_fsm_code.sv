
module TopModule (
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack
);

  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      pattern_reg <= 4'b0000;
      shift_counter <= 2'b00;
      shift_ena <= 1'b0;
      counting <= 1'b0;
      done <= 1'b0;
    end else begin
      state <= next_state;
      
      // Pattern detection shift register
      pattern_reg <= {pattern_reg[2:0], data};
      
      // Shift counter for controlling shift_ena duration
      if (state == SHIFTING) begin
        shift_counter <= shift_counter + 1'b1;
      end else begin
        shift_counter <= 2'b00;
      end
      
      // Output assignments based on state
      case (state)
        IDLE: begin
          shift_ena <= 1'b0;
          counting <= 1'b0;
          done <= 1'b0;
        end
        SHIFTING: begin
          shift_ena <= 1'b1;
          counting <= 1'b0;
          done <= 1'b0;
        end
        COUNTING: begin
          shift_ena <= 1'b0;
          counting <= 1'b1;
          done <= 1'b0;
        end
        DONE: begin
          shift_ena <= 1'b0;
          counting <= 1'b0;
          done <= 1'b1;
        end
      endcase
    end
  end
  
  // Next state logic
  always @(*) begin
    next_state = state;
    
    case (state)
      IDLE: begin
        if (pattern_reg == 4'b1101) begin
          next_state = SHIFTING;
        end
      end
      
      SHIFTING: begin
        if (shift_counter == 2'b11) begin  // After 4 cycles (counter counts 0,1,2,3)
          next_state = COUNTING;
        end
      end
      
      COUNTING: begin
        if (done_counting) begin
          next_state = DONE;
        end
      end
      
      DONE: begin
        if (ack) begin
          next_state = IDLE;
        end
      end
    endcase
  end
  
endmodule

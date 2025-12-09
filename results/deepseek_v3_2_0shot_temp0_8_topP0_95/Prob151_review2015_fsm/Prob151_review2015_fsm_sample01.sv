
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
  reg [3:0] state, next_state;
  reg [3:0] pattern_reg;
  
  localparam IDLE    = 4'd0,
             SHIFT   = 4'd1,
             COUNT   = 4'd2,
             NOTIFY  = 4'd3;
  
  // State register
  always @(posedge clk) begin
    if (reset) state <= IDLE;
    else state <= next_state;
  end
  
  // Pattern shift register
  always @(posedge clk) begin
    if (reset) pattern_reg <= 4'b0;
    else pattern_reg <= {pattern_reg[2:0], data};
  end
  
  // Next state logic
  always @(*) begin
    next_state = state;
    case (state)
      IDLE: begin
        if (pattern_reg == 4'b1101)
          next_state = SHIFT;
      end
      SHIFT: begin
        // After 4 cycles, go to COUNT
        // We'll use a small counter to track 4 shifts
        // but here we handle via a separate counter reg
      end
      COUNT: begin
        if (done_counting)
          next_state = NOTIFY;
      end
      NOTIFY: begin
        if (ack)
          next_state = IDLE;
      end
    endcase
  end
  
  // Shift cycle counter
  reg [1:0] shift_cnt;
  always @(posedge clk) begin
    if (reset) shift_cnt <= 2'b0;
    else if (state == SHIFT) shift_cnt <= shift_cnt + 1'b1;
    else shift_cnt <= 2'b0;
  end
  
  // SHIFT state transition after 4 cycles
  always @(*) begin
    if (state == SHIFT && shift_cnt == 2'b11)
      next_state = COUNT;
  end
  
  // Output logic
  always @(posedge clk) begin
    if (reset) begin
      shift_ena <= 1'b0;
      counting  <= 1'b0;
      done      <= 1'b0;
    end else begin
      shift_ena <= (state == SHIFT);
      counting  <= (state == COUNT);
      done      <= (state == NOTIFY);
    end
  end
endmodule

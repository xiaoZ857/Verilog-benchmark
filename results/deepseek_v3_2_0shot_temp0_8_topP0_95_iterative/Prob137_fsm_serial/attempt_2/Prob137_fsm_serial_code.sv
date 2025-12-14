
module TopModule (
  input clk,
  input in,
  input reset,
  output done
);
  // States - need 4 bits to represent states 0-11
  localparam IDLE = 4'd0;
  localparam START = 4'd1;
  localparam DATA0 = 4'd2;
  localparam DATA1 = 4'd3;
  localparam DATA2 = 4'd4;
  localparam DATA3 = 4'd5;
  localparam DATA4 = 4'd6;
  localparam DATA5 = 4'd7;
  localparam DATA6 = 4'd8;
  localparam DATA7 = 4'd9;
  localparam STOP = 4'd10;
  localparam ERROR = 4'd11;
  
  reg [3:0] state, next_state;
  reg done_reg;
  
  // State register
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      IDLE: begin
        if (in == 1'b0) next_state = START;  // start bit detected
        else next_state = IDLE;
      end
      START: begin
        next_state = DATA0;  // move to first data bit
      end
      DATA0: next_state = DATA1;
      DATA1: next_state = DATA2;
      DATA2: next_state = DATA3;
      DATA3: next_state = DATA4;
      DATA4: next_state = DATA5;
      DATA5: next_state = DATA6;
      DATA6: next_state = DATA7;
      DATA7: begin
        // After 8th data bit, check stop bit
        if (in == 1'b1) next_state = STOP;
        else next_state = ERROR;  // missing stop bit
      end
      STOP: begin
        // After correct stop bit, check for next start bit
        if (in == 1'b0) next_state = START;
        else next_state = IDLE;
      end
      ERROR: begin
        // Wait until we see a stop bit (1) before looking for next start
        if (in == 1'b1) next_state = IDLE;
        else next_state = ERROR;  // stay in error until line goes high
      end
      default: next_state = IDLE;
    endcase
  end
  
  // Output logic: done is high for one cycle when correct stop bit is received
  // This happens when we transition from DATA7 to STOP (when in==1 in DATA7 state)
  always @(posedge clk) begin
    if (reset) begin
      done_reg <= 1'b0;
    end else begin
      // Assert done when we're in DATA7 state and the next bit is 1 (stop bit)
      // and we're about to transition to STOP state
      if (state == DATA7 && in == 1'b1) begin
        done_reg <= 1'b1;
      end else begin
        done_reg <= 1'b0;
      end
    end
  end
  
  assign done = done_reg;
endmodule

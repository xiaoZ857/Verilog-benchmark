
module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

// State machine definitions
localparam IDLE = 2'b00;
localparam CAPTURE_DELAY = 2'b01;
localparam COUNTING = 2'b10;
localparam DONE = 2'b11;

reg [1:0] state, next_state;
reg [3:0] pattern_shift;
  
// Delay value and counters
reg [3:0] delay_reg;
reg [13:0] cycle_counter; // Count up to 1000 * 16 = 16000 (need 14 bits)
reg [3:0] count_reg;
reg [2:0] delay_capture_count; // Count bits captured for delay

// State machine
always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    pattern_shift <= 4'b0000;
    delay_reg <= 4'b0000;
    cycle_counter <= 14'b00000000000000;
    count_reg <= 4'b0000;
    delay_capture_count <= 3'b000;
    counting <= 1'b0;
    done <= 1'b0;
  end else begin
    state <= next_state;
    
    case (state)
      IDLE: begin
        // Shift pattern detection register
        pattern_shift <= {pattern_shift[2:0], data};
        counting <= 1'b0;
        done <= 1'b0;
      end
      
      CAPTURE_DELAY: begin
        // Capture delay bits (MSB first)
        delay_reg <= {delay_reg[2:0], data};
        delay_capture_count <= delay_capture_count + 1;
        counting <= 1'b0;
        done <= 1'b0;
      end
      
      COUNTING: begin
        counting <= 1'b1;
        done <= 1'b0;
        cycle_counter <= cycle_counter + 1;
        
        // Update count output every 1000 cycles
        if (cycle_counter == 14'd999) begin
          count_reg <= count_reg - 1;
          cycle_counter <= 14'b00000000000000;
        end
      end
      
      DONE: begin
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
      if (pattern_shift == 4'b1101) begin
        next_state = CAPTURE_DELAY;
      end
    end
    
    CAPTURE_DELAY: begin
      if (delay_capture_count == 3'b011) begin // 4 bits captured (0,1,2,3)
        next_state = COUNTING;
        // Initialize count_reg with delay_reg value
        count_reg = delay_reg;
        cycle_counter = 14'b00000000000000;
      end
    end
    
    COUNTING: begin
      if ((count_reg == 4'b0000) && (cycle_counter == 14'd999)) begin
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

// Output assignments
assign count = (state == COUNTING) ? count_reg : 4'b0000;

endmodule


module TopModule (
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack
);

// State machine states
localparam IDLE = 2'b00;
localparam CAPTURE_DELAY = 2'b01;
localparam COUNTING = 2'b10;
localparam DONE = 2'b11;

reg [1:0] state, next_state;
reg [3:0] pattern_shift; // Shift register for pattern detection
reg [3:0] delay_reg; // Store the delay value
reg [9:0] cycle_counter; // Counter for 1000 cycles
reg [3:0] current_delay; // Current delay value being counted
reg [1:0] bit_count; // Counter for capturing 4 bits

// State transition logic
always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    pattern_shift <= 4'b0000;
    delay_reg <= 4'b0000;
    cycle_counter <= 10'b0000000000;
    current_delay <= 4'b0000;
    bit_count <= 2'b00;
    counting <= 1'b0;
    done <= 1'b0;
  end else begin
    state <= next_state;
    
    case (state)
      IDLE: begin
        pattern_shift <= {pattern_shift[2:0], data};
        counting <= 1'b0;
        done <= 1'b0;
      end
      
      CAPTURE_DELAY: begin
        delay_reg <= {delay_reg[2:0], data};
        bit_count <= bit_count + 1;
      end
      
      COUNTING: begin
        cycle_counter <= cycle_counter + 1;
        if (cycle_counter == 999) begin
          cycle_counter <= 0;
          if (current_delay == 0) begin
            current_delay <= delay_reg;
          end else begin
            current_delay <= current_delay - 1;
          end
        end
      end
      
      DONE: begin
        // Wait for ack
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
      if (bit_count == 3) begin
        next_state = COUNTING;
      end
    end
    
    COUNTING: begin
      if (cycle_counter == 999 && current_delay == 0) begin
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

// Output logic
assign count = (state == COUNTING) ? current_delay : 4'b0000;

always @(posedge clk) begin
  if (reset) begin
    counting <= 1'b0;
    done <= 1'b0;
  end else begin
    case (state)
      COUNTING: begin
        counting <= 1'b1;
        done <= 1'b0;
      end
      
      DONE: begin
        counting <= 1'b0;
        done <= 1'b1;
      end
      
      default: begin
        counting <= 1'b0;
        done <= 1'b0;
      end
    endcase
  end
end

endmodule

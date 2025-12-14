
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

reg [1:0] state, next_state;
localparam IDLE = 2'b00;
localparam SHIFT = 2'b01;
localparam COUNT = 2'b10;
localparam DONE = 2'b11;

// 4-bit pattern register to detect 1101
reg [3:0] pattern_reg;
// Counter to track 4 shift cycles
reg [1:0] shift_counter;

// State register update
always @(posedge clk) begin
  if (reset) begin
    state <= IDLE;
    pattern_reg <= 4'b0000;
    shift_counter <= 2'b00;
  end
  else begin
    state <= next_state;
    
    // Update pattern register - always shift in data
    pattern_reg <= {pattern_reg[2:0], data};
    
    // Update shift counter
    if (state == SHIFT) begin
      shift_counter <= shift_counter + 1;
    end else begin
      shift_counter <= 2'b00;
    end
  end
end

// Next state logic
always @(*) begin
  next_state = state;
  
  case (state)
    IDLE: begin
      if (pattern_reg == 4'b1101) begin
        next_state = SHIFT;
      end
    end
    
    SHIFT: begin
      if (shift_counter == 2'b11) begin
        next_state = COUNT;
      end
    end
    
    COUNT: begin
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

// Output logic
always @(posedge clk) begin
  if (reset) begin
    shift_ena <= 1'b0;
    counting <= 1'b0;
    done <= 1'b0;
  end
  else begin
    // Default outputs
    shift_ena <= 1'b0;
    counting <= 1'b0;
    done <= 1'b0;
    
    // Set outputs based on current state
    case (state)
      SHIFT: begin
        shift_ena <= 1'b1;
      end
      
      COUNT: begin
        counting <= 1'b1;
      end
      
      DONE: begin
        done <= 1'b1;
      end
    endcase
  end
end

endmodule

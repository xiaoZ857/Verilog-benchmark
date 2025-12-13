
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

// State encoding for water levels
localparam STATE_LOW      = 2'b00;  // Below s[1]
localparam STATE_MID_LOW  = 2'b01;  // Between s[2] and s[1]
localparam STATE_MID_HIGH = 2'b10;  // Between s[3] and s[2]
localparam STATE_HIGH     = 2'b11;  // Above s[3]

reg [1:0] current_state, next_state;
reg [1:0] prev_state;  // Track previous state for dfr determination

// State transition logic
always @(posedge clk) begin
  if (reset) begin
    current_state <= STATE_LOW;
    prev_state <= STATE_LOW;
  end else begin
    prev_state <= current_state;
    current_state <= next_state;
  end
end

// Next state logic based on sensor inputs
always @(*) begin
  case (s)
    3'b111: next_state = STATE_HIGH;      // Above s[3]
    3'b110: next_state = STATE_MID_HIGH;  // Between s[3] and s[2]
    3'b100: next_state = STATE_MID_LOW;   // Between s[2] and s[1]
    3'b000: next_state = STATE_LOW;       // Below s[1]
    default: next_state = current_state;  // Hold state for invalid combinations
  endcase
end

// Output logic based on current state and level change
always @(posedge clk) begin
  if (reset) begin
    // Reset to low water level state (all outputs asserted)
    fr1 <= 1'b1;
    fr2 <= 1'b1;
    fr3 <= 1'b1;
    dfr <= 1'b0;
  end else begin
    // Determine nominal flow rate based on current state
    case (current_state)
      STATE_HIGH: begin
        fr1 <= 1'b0;
        fr2 <= 1'b0;
        fr3 <= 1'b0;
      end
      STATE_MID_HIGH: begin
        fr1 <= 1'b1;
        fr2 <= 1'b0;
        fr3 <= 1'b0;
      end
      STATE_MID_LOW: begin
        fr1 <= 1'b1;
        fr2 <= 1'b1;
        fr3 <= 1'b0;
      end
      STATE_LOW: begin
        fr1 <= 1'b1;
        fr2 <= 1'b1;
        fr3 <= 1'b1;
      end
    endcase
    
    // Set dfr based on whether water level is rising
    if (current_state > prev_state) begin
      dfr <= 1'b1;
    end else begin
      dfr <= 1'b0;
    end
  end
end

endmodule

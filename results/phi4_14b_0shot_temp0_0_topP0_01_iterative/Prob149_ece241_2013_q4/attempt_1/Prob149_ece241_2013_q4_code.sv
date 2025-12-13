
module TopModule (
  input clk,
  input reset,
  input [3:1] s, // Sensors s[3], s[2], s[1]
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

  // State encoding
  typedef enum logic [1:0] {
    STATE_LOW = 2'b00,   // Below s[1]
    STATE_MID = 2'b01,   // Between s[2] and s[1]
    STATE_HIGH = 2'b10,  // Between s[3] and s[2]
    STATE_VHIGH = 2'b11  // Above s[3]
  } state_t;

  state_t current_state, next_state;
  state_t previous_state;

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset to the equivalent of being low for a long time
      fr3 <= 1'b1;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      dfr <= 1'b0; // No need to open supplemental valve on reset
      current_state <= STATE_LOW;
    end else begin
      current_state <= next_state;
      
      case (current_state)
        STATE_LOW: begin
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b0;
        end
        STATE_MID: begin
          fr3 <= 1'b0;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= (previous_state == STATE_LOW) ? 1'b1 : 1'b0; // Open if rising from low
        end
        STATE_HIGH: begin
          fr3 <= 1'b0;
          fr2 <= 1'b0;
          fr1 <= 1'b1;
          dfr <= (previous_state == STATE_MID) ? 1'b1 : 1'b0; // Open if rising from mid
        end
        STATE_VHIGH: begin
          fr3 <= 1'b0;
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          dfr <= 1'b0;
        end
      endcase
    end
  end

  always_comb begin
    // Determine next state based on sensor inputs
    case (s)
      3'b111: next_state = STATE_VHIGH; // Above s[3]
      3'b110, 3'b101: next_state = STATE_HIGH; // Between s[3] and s[2]
      3'b011, 3'b010, 3'b001: next_state = STATE_MID; // Between s[2] and s[1]
      default: next_state = STATE_LOW; // Below s[1]
    endcase

    previous_state = current_state;
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

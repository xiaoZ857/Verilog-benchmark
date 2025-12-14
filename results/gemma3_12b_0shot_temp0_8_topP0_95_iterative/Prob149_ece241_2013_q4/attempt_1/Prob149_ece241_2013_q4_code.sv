
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

  // Define states
  typedef enum logic [1:0] {
    STATE_LOW = 2'b00,
    STATE_BELOW_3 = 2'b01,
    STATE_BELOW_2 = 2'b10,
    STATE_NORMAL = 2'b11
  } state_t;

  reg state, next_state;
  reg last_s;  // Store the previous sensor asserted state

  // State register update on clock edge
  always_ff @(posedge clk) begin
    if (reset) begin
      state <= STATE_LOW;
      last_s <= 4'b0000; // Initialize to all sensors not asserted
    end else begin
      state <= next_state;
      last_s <= s;
    end
  end

  // Next state logic
  always_comb begin
    next_state = state; // Default to staying in the current state

    case (state)
      STATE_LOW: begin
        if (~s[1]) begin // Below lowest sensor
          next_state = STATE_LOW;
        end else if (~s[2]) begin  // Between s[2] and s[1]
          next_state = STATE_BELOW_2;
        end else if (~s[3]) begin // Between s[3] and s[2]
          next_state = STATE_BELOW_3;
        end else begin // Above s[3]
          next_state = STATE_NORMAL;
        end
      end

      STATE_BELOW_3: begin
        if (~s[1]) begin
          next_state = STATE_LOW;
        end else if (~s[2]) begin
          next_state = STATE_BELOW_2;
        end else begin
          next_state = STATE_NORMAL;
        end
      end

      STATE_BELOW_2: begin
        if (~s[1]) begin
          next_state = STATE_LOW;
        end else begin
          next_state = STATE_NORMAL;
        end
      end

      STATE_NORMAL: begin
        if (~s[1]) begin
          next_state = STATE_LOW;
        end else if (~s[2]) begin
          next_state = STATE_BELOW_2;
        end else if (~s[3]) begin
          next_state = STATE_BELOW_3;
        end else begin
          next_state = STATE_NORMAL;
        end
      end

      default:
        next_state = STATE_NORMAL;
    endcase
  end


  // Output logic
  always_comb begin
    fr3 = 0;
    fr2 = 0;
    fr1 = 0;
    dfr = 0;

    case (state)
      STATE_LOW: begin
        fr1 = 1;
        fr2 = 1;
        fr3 = 1;
        dfr = 1;
      end

      STATE_BELOW_3: begin
        fr1 = 0;
        fr2 = 1;
        fr3 = 0;
        dfr = 1;
      end

      STATE_BELOW_2: begin
        fr1 = 0;
        fr2 = 1;
        fr3 = 1;
        dfr = 1;
      end

      STATE_NORMAL: begin
        if (last_s[3] == 1 && s[3] == 0) begin  // Level decreased from above s[3]
          dfr = 1;
        end else begin
          dfr = 0;
        end

        if (s[3] == 0) begin // Between s[3] and s[2]
          fr1 = 1;
          fr2 = 0;
          fr3 = 0;
          dfr = dfr;
        end else if (s[2] == 0) begin // Between s[2] and s[1]
          fr1 = 1;
          fr2 = 1;
          fr3 = 0;
          dfr = dfr;
        end else begin // Above s[2]
          fr

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found

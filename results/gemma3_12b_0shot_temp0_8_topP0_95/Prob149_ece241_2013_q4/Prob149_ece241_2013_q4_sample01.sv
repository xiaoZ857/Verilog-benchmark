
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
  parameter LOW_STATE = 2'b00
  parameter MID_LOW_STATE = 2'b01
  parameter MID_HIGH_STATE = 2'b10
  parameter HIGH_STATE = 2'b11

  reg [1:0] current_state;
  reg [1:0] next_state;
  reg sensor_change;

  // State transition logic
  always @(posedge clk) begin
    if (reset) begin
      current_state <= LOW_STATE;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state logic
  always @(posedge clk) begin
    if (reset) begin
      next_state <= LOW_STATE;
    end else begin
      // Determine if a sensor change occurred
      sensor_change = 0;
      if (s[1] != current_state[1] | s[2] != current_state[0] | s[3] != current_state[0])
        sensor_change = 1;

      case (current_state)
        LOW_STATE: begin
          if (s[1]) begin
            next_state <= MID_LOW_STATE;
          end else begin
            next_state <= LOW_STATE;
          end
        end
        MID_LOW_STATE: begin
          if (s[2]) begin
            next_state <= MID_HIGH_STATE;
          end else begin
            next_state <= MID_LOW_STATE;
          end
        end
        MID_HIGH_STATE: begin
          if (s[3]) begin
            next_state <= HIGH_STATE;
          end else begin
            next_state <= MID_HIGH_STATE;
          end
        end
        HIGH_STATE: begin
          if (!s[3]) begin
            next_state <= MID_HIGH_STATE;
          end else begin
            next_state <= HIGH_STATE;
          end
        end
        default: begin
          next_state <= LOW_STATE;
        end
      endcase
    end
  end

  // Output logic
  always @(posedge clk) begin
    if (reset) begin
      fr3 <= 1;
      fr2 <= 1;
      fr1 <= 1;
      dfr <= 1;
    end else begin
      case (current_state)
        LOW_STATE: begin
          fr3 <= 1;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;
        end
        MID_LOW_STATE: begin
          fr3 <= 0;
          fr2 <= 0;
          fr1 <= 1;
          dfr <= 1;
        end
        MID_HIGH_STATE: begin
          fr3 <= 0;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;
        end
        HIGH_STATE: begin
          fr3 <= 0;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 0;
        end
        default: begin
          fr3 <= 1;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;
        end
      endcase
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

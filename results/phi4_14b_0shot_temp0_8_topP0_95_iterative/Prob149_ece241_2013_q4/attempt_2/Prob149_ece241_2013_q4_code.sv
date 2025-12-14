
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
  typedef enum reg [1:0] {
    ABOVE_S3 = 2'b00,
    BETWEEN_S3_S2 = 2'b01,
    BETWEEN_S2_S1 = 2'b10,
    BELOW_S1 = 2'b11
  } state_t;

  state_t current_state, next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset to a state equivalent to water level being below s[1]
      current_state <= BELOW_S1;
    end else begin
      current_state <= next_state;
    end
  end

  always @(*) begin
    // Default outputs for the transition logic and output control
    fr3 = 0;
    fr2 = 0;
    fr1 = 0;
    dfr = 0;

    case (current_state)
      ABOVE_S3: begin
        fr3 <= 0;
        fr2 <= 0;
        fr1 <= 0;
        dfr <= 0;
      end

      BETWEEN_S3_S2: begin
        fr3 <= 0;
        fr2 <= 0;
        fr1 <= 1; // Nominal flow rate fr1 asserted
        if (next_state == BELOW_S2 || next_state == BETWEEN_S2_S1) begin
          dfr <= 1; // Increase flow by opening the Supplemental valve
        end else begin
          dfr <= 0;
        end
      end

      BETWEEN_S2_S1: begin
        fr3 <= 0;
        fr2 <= 1; // Nominal flow rate fr2 asserted
        fr1 <= 1; // Nominal flow rate fr1 asserted
        if (next_state == BELOW_S1) begin
          dfr <= 1; // Increase flow by opening the Supplemental valve
        end else begin
          dfr <= 0;
        end
      end

      BELOW_S1: begin
        fr3 <= 1; // Maximum flow rate with all valves open
        fr2 <= 1;
        fr1 <= 1;
        dfr <= 0;
      end

    endcase
  end
  
  always @(*) begin
    // Determine next state based on sensor input s
    if (s[3]) begin
      next_state = ABOVE_S3;
    end else if (s[2]) begin
      next_state = BETWEEN_S3_S2;
    end else if (s[1]) begin
      next_state = BETWEEN_S2_S1;
    end else begin
      next_state = BELOW_S1;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

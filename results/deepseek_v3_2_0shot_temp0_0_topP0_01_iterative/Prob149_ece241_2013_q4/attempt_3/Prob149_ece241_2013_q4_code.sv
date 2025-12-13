
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
  reg [1:0] state, next_state;
  reg [1:0] prev_state;
  
  // States ordered by water level (lowest to highest)
  localparam BELOW_S1      = 2'b00,    // No sensors asserted
             BETWEEN_S1_S2 = 2'b01,    // Only s[1] asserted
             BETWEEN_S2_S3 = 2'b10,    // s[1] and s[2] asserted
             ABOVE_S3      = 2'b11;    // All sensors asserted
  
  // Determine current state based on sensor readings
  always @(*) begin
    case (s)
      3'b000: next_state = BELOW_S1;      // Below all sensors
      3'b001: next_state = BETWEEN_S1_S2; // Above s[1], below s[2]
      3'b011: next_state = BETWEEN_S2_S3; // Above s[1] and s[2], below s[3]
      3'b111: next_state = ABOVE_S3;      // Above all sensors
      default: next_state = state;        // Maintain current state for illegal patterns
    endcase
  end
  
  // Sequential logic
  always @(posedge clk) begin
    if (reset) begin
      state <= BELOW_S1;
      prev_state <= BELOW_S1;
    end else begin
      prev_state <= state;
      state <= next_state;
    end
  end
  
  // Determine if water level was previously lower (rising)
  // Compare states directly - if prev_state has lower value than current state,
  // water level is rising (states are encoded in order of increasing water level)
  wire rising;
  assign rising = (prev_state < state);
  
  // Output logic
  always @(*) begin
    case (state)
      BELOW_S1: begin
        fr3 = 1'b1;
        fr2 = 1'b1;
        fr1 = 1'b1;
        dfr = 1'b1;  // Supplemental flow always on when below s[1]
      end
      BETWEEN_S1_S2: begin
        fr3 = 1'b0;
        fr2 = 1'b1;
        fr1 = 1'b1;
        dfr = rising ? 1'b1 : 1'b0;  // Supplemental flow only if rising
      end
      BETWEEN_S2_S3: begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b1;
        dfr = rising ? 1'b1 : 1'b0;  // Supplemental flow only if rising
      end
      ABOVE_S3: begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;  // No flow when above s[3]
      end
      default: begin
        fr3 = 1'b0;
        fr2 = 1'b0;
        fr1 = 1'b0;
        dfr = 1'b0;
      end
    endcase
  end
endmodule

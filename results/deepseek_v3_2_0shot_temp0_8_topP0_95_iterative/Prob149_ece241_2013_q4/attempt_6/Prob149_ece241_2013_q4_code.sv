
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
  always @(posedge clk) begin
    if (reset) begin
      fr3 <= 1;
      fr2 <= 1;
      fr1 <= 1;
      dfr <= 1;
    end else begin
      // Default outputs: all valves closed (0) except dfr which depends on direction
      fr3 <= 0;
      fr2 <= 0;
      fr1 <= 0;
      dfr <= 0;

      // Determine water level based on sensors
      // The sensors are active high (1 = water at or above sensor)
      // s[3] is highest, s[1] is lowest
      case (s)
        3'b111: begin  // Above highest sensor s[3]
          // All sensors covered: no flow needed
          fr3 <= 0;
          fr2 <= 0;
          fr1 <= 0;
          dfr <= 0;
        end
        3'b110: begin  // Between s[3] and s[2] (s[3]=0, s[2]=1, s[1]=1)
          // Only s[2] and s[1] asserted
          fr3 <= 0;
          fr2 <= 0;
          fr1 <= 1;  // Nominal flow: fr1 only
          dfr <= 0;  // Supplemental flow off by default
        end
        3'b100: begin  // Between s[2] and s[1] (s[3]=0, s[2]=0, s[1]=1)
          // Only s[1] asserted
          fr3 <= 0;
          fr2 <= 1;  // Nominal flow: fr2
          fr1 <= 1;  // and fr1
          dfr <= 0;  // Supplemental flow off by default
        end
        3'b000: begin  // Below lowest sensor s[1]
          // No sensors asserted
          fr3 <= 1;  // Maximum flow: all valves open
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;  // Supplemental flow also on
        end
        default: begin
          // For other patterns (like 011, 101, etc.), use conservative approach
          // Assume water level is at the highest sensor that is asserted
          // This handles cases where sensors might not have ideal patterns
          if (s[3]) begin
            // s[3]=1 means water at or above highest sensor
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 0;
            dfr <= 0;
          end else if (s[2]) begin
            // s[2]=1, s[3]=0 means between s[3] and s[2]
            fr3 <= 0;
            fr2 <= 0;
            fr1 <= 1;
            dfr <= 0;
          end else if (s[1]) begin
            // s[1]=1, s[3:2]=0 means between s[2] and s[1]
            fr3 <= 0;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 0;
          end else begin
            // No sensors asserted
            fr3 <= 1;
            fr2 <= 1;
            fr1 <= 1;
            dfr <= 1;
          end
        end
      endcase
    end
  end
endmodule

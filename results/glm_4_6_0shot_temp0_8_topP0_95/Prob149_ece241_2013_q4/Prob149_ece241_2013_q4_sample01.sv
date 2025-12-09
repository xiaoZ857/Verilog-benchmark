
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
    // Reset to state equivalent to low water level for a long time
    // All flow valves open
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b0;
    prev_level <= 2'b00; // Below s[1]
  end else begin
    // Store previous level
    prev_level <= curr_level;
    
    // Update outputs based on current level
    case (curr_level)
      2'b11: begin // Above s[3] (111)
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
      end
      2'b10: begin // Between s[3] and s[2] (110)
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b1;
      end
      2'b01: begin // Between s[2] and s[1] (100)
        fr3 <= 1'b0;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
      end
      2'b00: begin // Below s[1] (000)
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
      end
    endcase
    
    // Determine dfr (supplemental flow valve)
    // Only active when level is between upper and lower sensors
    // AND previous level was lower than current level
    if (curr_level != 2'b11 && curr_level != 2'b00 && prev_level < curr_level) begin
      dfr <= 1'b1;
    end else begin
      dfr <= 1'b0;
    end
  end
end

endmodule

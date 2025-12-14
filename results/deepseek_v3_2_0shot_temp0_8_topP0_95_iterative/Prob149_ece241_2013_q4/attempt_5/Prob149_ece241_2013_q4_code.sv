
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
  reg [2:0] prev_s;
  
  always @(posedge clk) begin
    if (reset) begin
      fr3 <= 1;
      fr2 <= 1;
      fr1 <= 1;
      dfr <= 1;
      prev_s <= 3'b000;
    end else begin
      prev_s <= s;
      
      // Determine water level based on sensors
      case (s)
        3'b111: begin  // Above highest sensor s[3]
          fr3 <= 0;
          fr2 <= 0;
          fr1 <= 0;
          dfr <= 0;
        end
        3'b110: begin  // Between s[3] and s[2]
          fr3 <= 0;
          fr2 <= 0;
          fr1 <= 1;
          // dfr = 1 if water was rising (previous level was lower)
          // Need to check if previous state represents a lower water level
          case (prev_s)
            3'b000, 3'b001: dfr <= 1;  // Was below current level
            default: dfr <= 0;
          endcase
        end
        3'b100: begin  // Between s[2] and s[1]
          fr3 <= 0;
          fr2 <= 1;
          fr1 <= 1;
          // Check if previous level was lower
          case (prev_s)
            3'b000, 3'b001, 3'b110: dfr <= 1;  // Was below current level
            default: dfr <= 0;
          endcase
        end
        3'b000: begin  // Below lowest sensor s[1]
          fr3 <= 1;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;
        end
        default: begin  // Handle other sensor patterns
          // For patterns like 011, 101, etc., use conservative approach
          fr3 <= 1;
          fr2 <= 1;
          fr1 <= 1;
          dfr <= 1;
        end
      endcase
    end
  end
endmodule

// VERILOG-EVAL: abnormal backticks count

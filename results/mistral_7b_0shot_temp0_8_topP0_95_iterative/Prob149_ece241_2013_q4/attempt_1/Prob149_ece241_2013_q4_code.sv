
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

// Water level and previous water level
reg [1:0] water_level = {0, 0};
reg prev_water_level = 0;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    fr3 <= 0;
    fr2 <= 0;
    fr1 <= 0;
    dfr <= 0;
    water_level[0] <= 0;
    water_level[1] <= 0;
  end else if (s[3]) begin // Water level above s[3]
    fr3 <= 0;
    fr2 <= 0;
    fr1 <= 0;
    dfr <= 0;
    water_level <= {0, 0};
  end else if ((s[3] && !s[2]) || (prev_water_level == 2 && water_level == {1, 0})) begin // Between s[3] and s[2]
    fr3 <= 0;
    fr2 <= 0;
    fr1 <= 1'b1; // fr1
    dfr <= 0;
    water_level <= {1, 0};
  end else if ((s[3] && s[2]) || (prev_water_level == 3 && water_level == {1, 0})) begin // Between s[2] and s[1]
    fr3 <= 0;
    fr2 <= 1'b1; // fr2
    fr1 <= 1'b1; // fr1
    dfr <= 1'b0; // dfr
    water_level <= {1, 1};
  end else if (!s[1]) begin // Water level below s[1]
    fr3 <= 1'b1; // fr1
    fr2 <= 1'b1; // fr2
    fr1 <= 1'b1; // fr3
    dfr <= 1'b1; // dfr
    water_level <= {2, 1};
  end else begin // Water level between s[1] and s[2] or s[2] and s[3]
    if (prev_water_level < water_level) begin // If previous level was lower than current level
      fr3 <= 0;
      fr2 <= 0;
      fr1 <= 1'b1; // fr1
      dfr <= 1'b1; // dfr
    end else begin // If previous level was higher or equal to current level
      fr3 <= 0;
      fr2 <= 1'b1; // fr2
      fr1 <= 1'b1; // fr1
      dfr <= 1'b0; // dfr
    end
    water_level <= {water_level[1], water_level[0]};
  end
  prev_water_level = water_level[1];
end

// Note that this implementation does not include the actual nominal flow rate associated with each water level.

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found

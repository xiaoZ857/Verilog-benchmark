
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      // Handle boundary cells explicitly
      // Leftmost cell (i=0): left neighbor is 0, center = q[0], right = q[1]
      q[0] <= (1'b0 & q[0] & ~q[1]) | (1'b0 & ~q[0] & q[1]) | (~1'b0 & q[0] & q[1]) | (~1'b0 & ~q[0] & ~q[1]) ? 1'b0 : 1'b1;
      // Simplified using the rule table: left=0, center=q[0], right=q[1]
      // From table: 0,1,1->1; 0,1,0->1; 0,0,1->1; 0,0,0->0
      // So q[0] <= (q[0] & q[1]) | (~q[0] & q[1]) | (~q[0] & ~q[1] & 1'b0) ? But simpler:
      // Actually, it's 1 unless both q[0] and q[1] are 0.
      // So: q[0] <= ~(~q[0] & ~q[1]);
      // But let's use the explicit expression from the table for clarity:
      case ({1'b0, q[0], q[1]})
        3'b011: q[0] <= 1'b1;
        3'b010: q[0] <= 1'b1;
        3'b001: q[0] <= 1'b1;
        3'b000: q[0] <= 1'b0;
        default: q[0] <= 1'b0; // Should not happen
      endcase

      // Rightmost cell (i=511): left = q[510], center = q[511], right = 0
      case ({q[510], q[511], 1'b0})
        3'b110: q[511] <= 1'b1;
        3'b100: q[511] <= 1'b0;
        3'b010: q[511] <= 1'b1;
        3'b000: q[511] <= 1'b0;
        default: q[511] <= 1'b0; // Should not happen
      endcase

      // Internal cells
      for (integer i = 1; i < 511; i = i + 1) begin
        case ({q[i+1], q[i], q[i-1]})
          3'b111: q[i] <= 1'b0;
          3'b110: q[i] <= 1'b1;
          3'b101: q[i] <= 1'b1;
          3'b100: q[i] <= 1'b0;
          3'b011: q[i] <= 1'b1;
          3'b010: q[i] <= 1'b1;
          3'b001: q[i] <= 1'b1;
          3'b000: q[i] <= 1'b0;
        endcase
      end
    end
  end
endmodule

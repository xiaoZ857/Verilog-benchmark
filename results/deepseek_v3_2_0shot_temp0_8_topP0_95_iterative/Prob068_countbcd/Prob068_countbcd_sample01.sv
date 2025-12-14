
module TopModule (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);
  always @(posedge clk) begin
    if (reset) begin
      q <= 16'b0;
    end else begin
      // ones digit increment every clock
      if (q[3:0] == 4'd9) begin
        q[3:0] <= 4'd0;
        // tens digit increment if ones rolls over
        if (q[7:4] == 4'd9) begin
          q[7:4] <= 4'd0;
          // hundreds digit increment if tens rolls over
          if (q[11:8] == 4'd9) begin
            q[11:8] <= 4'd0;
            // thousands digit increment if hundreds rolls over
            if (q[15:12] == 4'd9) begin
              q[15:12] <= 4'd0;
            end else begin
              q[15:12] <= q[15:12] + 1'b1;
            end
          end else begin
            q[11:8] <= q[11:8] + 1'b1;
          end
        end else begin
          q[7:4] <= q[7:4] + 1'b1;
        end
      end else begin
        q[3:0] <= q[3:0] + 1'b1;
      end
    end
  end

  // ena[1] = 1 when ones == 9 (so next clock tens will increment)
  // ena[2] = 1 when ones == 9 and tens == 9
  // ena[3] = 1 when ones == 9 and tens == 9 and hundreds == 9
  assign ena[1] = (q[3:0] == 4'd9);
  assign ena[2] = (q[3:0] == 4'd9) && (q[7:4] == 4'd9);
  assign ena[3] = (q[3:0] == 4'd9) && (q[7:4] == 4'd9) && (q[11:8] == 4'd9);
endmodule

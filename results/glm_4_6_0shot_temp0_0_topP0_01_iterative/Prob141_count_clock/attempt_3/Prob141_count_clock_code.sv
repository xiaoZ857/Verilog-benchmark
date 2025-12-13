
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

always @(posedge clk) begin
  if (reset) begin
    // Reset to 12:00 AM
    pm <= 1'b0;
    hh <= 8'h12;  // 12 in BCD
    mm <= 8'h00;  // 00 in BCD
    ss <= 8'h00;  // 00 in BCD
  end else if (ena) begin
    // Increment seconds
    if (ss[3:0] == 4'h9) begin
      // Low digit reached 9, reset and increment high digit
      if (ss[7:4] == 4'h5) begin
        // Reached 59, reset to 00 and increment minutes
        ss <= 8'h00;
        if (mm[3:0] == 4'h9) begin
          // Low digit reached 9, reset and increment high digit
          if (mm[7:4] == 4'h5) begin
            // Reached 59, reset to 00 and increment hours
            mm <= 8'h00;
            if (hh == 8'h12) begin
              // At 12:00, toggle PM/AM and set to 1:00
              pm <= ~pm;
              hh <= 8'h01;
            end else if (hh[3:0] == 4'h9) begin
              // Low digit reached 9, reset and increment high digit
              hh <= {hh[7:4] + 1'b1, 4'h0};
            end else begin
              // Increment low digit
              hh <= {hh[7:4], hh[3:0] + 1'b1};
            end
          end else begin
            // Increment high digit of minutes
            mm <= {mm[7:4] + 1'b1, 4'h0};
          end
        end else begin
          // Increment low digit of minutes
          mm <= {mm[7:4], mm[3:0] + 1'b1};
        end
      end else begin
        // Increment high digit of seconds
        ss <= {ss[7:4] + 1'b1, 4'h0};
      end
    end else begin
      // Increment low digit of seconds
      ss <= {ss[7:4], ss[3:0] + 1'b1};
    end
  end
end
endmodule

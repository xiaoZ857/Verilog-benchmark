
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
  // Seconds counter
  always @(posedge clk) begin
    if (reset) begin
      ss <= 8'h00;
    end else if (ena) begin
      if (ss[3:0] == 4'd9) begin
        ss[3:0] <= 4'd0;
        if (ss[7:4] == 4'd5) begin
          ss[7:4] <= 4'd0;
        end else begin
          ss[7:4] <= ss[7:4] + 1;
        end
      end else begin
        ss[3:0] <= ss[3:0] + 1;
      end
    end
  end

  // Minutes counter (increments when seconds carry)
  wire min_inc = ena && (ss == 8'h59);
  always @(posedge clk) begin
    if (reset) begin
      mm <= 8'h00;
    end else if (min_inc) begin
      if (mm[3:0] == 4'd9) begin
        mm[3:0] <= 4'd0;
        if (mm[7:4] == 4'd5) begin
          mm[7:4] <= 4'd0;
        end else begin
          mm[7:4] <= mm[7:4] + 1;
        end
      end else begin
        mm[3:0] <= mm[3:0] + 1;
      end
    end
  end

  // Hours counter (increments when minutes carry)
  wire hour_inc = min_inc && (mm == 8'h59);
  always @(posedge clk) begin
    if (reset) begin
      hh <= 8'h12; // BCD 12
      pm <= 1'b0;
    end else if (hour_inc) begin
      // Handle hour increment with BCD
      if (hh == 8'h12) begin
        hh <= 8'h01;
        pm <= ~pm; // Toggle AM/PM at 12->01 transition
      end else if (hh[3:0] == 4'd9) begin
        // e.g., 09 -> 10
        hh[3:0] <= 4'd0;
        hh[7:4] <= hh[7:4] + 1;
      end else begin
        hh[3:0] <= hh[3:0] + 1;
      end
    end
  end

endmodule

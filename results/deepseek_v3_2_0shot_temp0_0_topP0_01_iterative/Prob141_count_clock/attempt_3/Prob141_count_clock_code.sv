
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
  // Internal BCD counters for seconds, minutes, and hours
  reg [3:0] ss_ones, ss_tens;
  reg [3:0] mm_ones, mm_tens;
  reg [3:0] hh_ones, hh_tens;
  
  // Seconds counter logic (00-59)
  always @(posedge clk) begin
    if (reset) begin
      ss_ones <= 4'd0;
      ss_tens <= 4'd0;
    end
    else if (ena) begin
      if (ss_ones == 4'd9) begin
        ss_ones <= 4'd0;
        if (ss_tens == 4'd5) begin
          ss_tens <= 4'd0;
        end
        else begin
          ss_tens <= ss_tens + 4'd1;
        end
      end
      else begin
        ss_ones <= ss_ones + 4'd1;
      end
    end
  end
  
  // Minutes counter logic (00-59) - increments when seconds roll over from 59 to 00
  wire min_inc = ena && (ss_ones == 4'd9) && (ss_tens == 4'd5);
  
  always @(posedge clk) begin
    if (reset) begin
      mm_ones <= 4'd0;
      mm_tens <= 4'd0;
    end
    else if (min_inc) begin
      if (mm_ones == 4'd9) begin
        mm_ones <= 4'd0;
        if (mm_tens == 4'd5) begin
          mm_tens <= 4'd0;
        end
        else begin
          mm_tens <= mm_tens + 4'd1;
        end
      end
      else begin
        mm_ones <= mm_ones + 4'd1;
      end
    end
  end
  
  // Hours counter logic (01-12 with AM/PM) - increments when minutes roll over from 59 to 00
  wire hour_inc = min_inc && (mm_ones == 4'd9) && (mm_tens == 4'd5);
  
  always @(posedge clk) begin
    if (reset) begin
      hh_ones <= 4'd2;  // 12:00 AM
      hh_tens <= 4'd1;
      pm <= 1'b0;
    end
    else if (hour_inc) begin
      // Handle hour increment with BCD 01-12
      if (hh_ones == 4'd2 && hh_tens == 4'd1) begin  // 12 -> 01
        hh_ones <= 4'd1;
        hh_tens <= 4'd0;
      end
      else if (hh_ones == 4'd9) begin  // 09 -> 10
        hh_ones <= 4'd0;
        hh_tens <= hh_tens + 4'd1;
      end
      else if (hh_ones == 4'd1 && hh_tens == 4'd1) begin  // 11 -> 12
        hh_ones <= 4'd2;
        hh_tens <= 4'd1;
        pm <= ~pm;  // Toggle AM/PM at 11:59:59 -> 12:00:00
      end
      else begin
        hh_ones <= hh_ones + 4'd1;
      end
    end
  end
  
  // Output assignments
  always @(posedge clk) begin
    if (reset) begin
      hh <= {4'd1, 4'd2};  // 12
      mm <= 8'h00;
      ss <= 8'h00;
    end
    else begin
      hh <= {hh_tens, hh_ones};
      mm <= {mm_tens, mm_ones};
      ss <= {ss_tens, ss_ones};
    end
  end

endmodule

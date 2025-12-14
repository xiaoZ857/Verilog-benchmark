
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  // BCD increment function for 00-59
  function [7:0] bcd_increment_59;
    input [7:0] bcd;
    reg [3:0] units, tens;
    begin
      units = bcd[3:0];
      tens = bcd[7:4];
      
      if (units == 4'h9) begin
        units = 4'h0;
        if (tens == 4'h5) begin
          tens = 4'h0;
        end else begin
          tens = tens + 4'h1;
        end
      end else begin
        units = units + 4'h1;
      end
      
      bcd_increment_59 = {tens, units};
    end
  endfunction
  
  // BCD increment function for hours (01-12)
  function [7:0] bcd_increment_hours;
    input [7:0] bcd;
    reg [3:0] units, tens;
    begin
      units = bcd[3:0];
      tens = bcd[7:4];
      
      if (bcd == 8'h12) begin
        // 12:00 -> 01:00
        bcd_increment_hours = 8'h01;
      end else if (units == 4'h9) begin
        // 09 -> 10
        bcd_increment_hours = {4'h1, 4'h0};
      end else begin
        // Normal increment
        bcd_increment_hours = {tens, units + 4'h1};
      end
    end
  endfunction
  
  // Main clock logic
  always @(posedge clk) begin
    if (reset) begin
      // Reset to 12:00:00 AM
      ss <= 8'h00;
      mm <= 8'h00;
      hh <= 8'h12;
      pm <= 1'b0;
      min_inc <= 1'b0;
      hour_inc <= 1'b0;
      pm_toggle <= 1'b0;
    end else if (ena) begin
      // Increment seconds
      if (ss == 8'h59) begin
        ss <= 8'h00;
        min_inc <= 1'b1;
      end else begin
        ss <= bcd_increment_59(ss);
        min_inc <= 1'b0;
      end
      
      // Increment minutes
      if (min_inc) begin
        if (mm == 8'h59) begin
          mm <= 8'h00;
          hour_inc <= 1'b1;
        end else begin
          mm <= bcd_increment_59(mm);
          hour_inc <= 1'b0;
        end
      end else begin
        hour_inc <= 1'b0;
      end
      
      // Increment hours and toggle PM
      if (hour_inc) begin
        if (hh == 8'h11) begin
          // Going from 11:59 to 12:00 toggles AM/PM
          hh <= bcd_increment_hours(hh);
          pm_toggle <= 1'b1;
        end else begin
          hh <= bcd_increment_hours(hh);
          pm_toggle <= 1'b0;
        end
      end else begin
        pm_toggle <= 1'b0;
      end
      
      // Update PM indicator
      if (pm_toggle) begin
        pm <= ~pm;
      end
    end
  end
endmodule

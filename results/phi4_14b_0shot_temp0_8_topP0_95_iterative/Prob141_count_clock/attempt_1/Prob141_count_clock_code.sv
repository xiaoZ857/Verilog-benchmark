
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm, // PM indicator: 1 for PM, 0 for AM
  output reg [7:0] hh, // Hours (BCD)
  output reg [7:0] mm, // Minutes (BCD)
  output reg [7:0] ss // Seconds (BCD)
);

  // Internal signals to track the BCD values
  reg [3:0] sec_low, sec_high; // Seconds counter
  reg [3:0] min_low, min_high; // Minutes counter
  reg [3:0] hour_low, hour_high; // Hours counter

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset to "12:00 AM"
      sec_low <= 4'b0000;
      sec_high <= 4'b0000;
      min_low <= 4'b0000;
      min_high <= 4'b0000;
      hour_low <= 4'b0010; // BCD for '2'
      hour_high <= 4'b0001; // BCD for '1'
      pm <= 1'b0; // AM
    end else if (ena) begin
      // Increment seconds
      if (sec_low == 4'd9) begin
        sec_low <= 4'b0000;
        if (sec_high == 4'd5) begin
          sec_high <= 4'b0000;
          // Increment minutes
          if (min_low == 4'd9) begin
            min_low <= 4'b0000;
            if (min_high == 4'd5) begin
              min_high <= 4'b0000;
              // Increment hours
              if (hour_low == 4'd9) begin
                hour_low <= 4'b0000;
                if (hour_high == 4'd2 && sec_high == 4'b0001) begin
                  hour_high <= 4'b0001; // 12 to 01
                  pm <= ~pm; // Toggle AM/PM
                end else if (hour_high < 4'd2) begin
                  hour_high <= hour_high + 1;
                end
              end else begin
                hour_low <= hour_low + 1;
              end
            end else begin
              min_high <= min_high + 1;
            end
          end else begin
            min_low <= min_low + 1;
          end
        end else begin
          sec_high <= sec_high + 1;
        end
      end else begin
        sec_low <= sec_low + 1;
      end
    end
  end

  // Update BCD outputs
  always @(*) begin
    hh = {hour_high, hour_low};
    mm = {min_high, min_low};
    ss = {sec_high, sec_low};
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition

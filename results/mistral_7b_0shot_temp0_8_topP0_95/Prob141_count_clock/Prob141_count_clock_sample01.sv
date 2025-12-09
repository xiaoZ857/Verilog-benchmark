
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

// BCD to decimal function
function int bcd2dec;
  input [3:0] bcd;
  bcd2dec = bcd + 6 * (bcd[3]);
endfunction

// Reset logic
always @(posedge reset or posedge clk) begin
  if (reset) begin
    hh <= 8'b1011_0000; // Set to 12:00 AM after reset
    mm <= 8'b0000_0000;
    ss <= 8'b0000_0000;
    pm <= 1'b0;
  end
end

// Counting logic for hours, minutes, and seconds
always @(posedge clk) begin
  if (ena && !reset) begin
    if (pm) begin // For PM mode
      if (hh == 12'b1111_1100) begin
        hh <= 8'b0000_0000;
        pm <= ~pm;
      end else begin
        hh <= hh + 1;
      end
    end
    if (hh > 12'b0011_1111) begin // Roll over to AM after 12:59
      hh <= 8'b0000_0000;
      pm <= ~pm;
    end

    if (mm == 64'b1111_1111) begin
      mm <= 8'b0000_0000;
      hh += 1; // Increment hours when minutes roll over to 0
    end else begin
      mm <= mm + 1;
    end

    if (ss == 64'b1111_1111) begin
      ss <= 8'b0000_0000;
      mm += 1; // Increment minutes when seconds roll over to 0
    end else begin
      ss <= ss + 1;
    end
  end
end

// Convert BCD to binary for AM/PM indicator
always @(posedge clk) begin
  pm <= (hh[3]) ? 1'b1 : 1'b0; // Set PM if hours are greater than or equal to 13
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found


module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    hh <= 8'b0001_0010; // Reset to 12:00 AM (12 hours and 0 minutes in BCD)
    mm <= 8'b0000_0000; // Reset to 0 minutes
    ss <= 8'b0000_0000; // Reset to 0 seconds
    pm <= 0; // AM by default
  end else if (ena) begin
    hh <= hh + 1; // Increment hours counter
    mm <= mm + 1; // Increment minutes counter
    ss <= ss + 1; // Increment seconds counter

    // Carry propagation for hours
    assign temp = hh[6];
    assign hh[7] = temp;

    // If hour is greater than 12, reset the hour and set PM
    if (hh > 8'b1101_1111) begin
      hh <= 8'b0001_0000;
      pm <= 1; // PM
    end
  end
end

// AM/PM indicator based on the hour value
always @(posedge clk) begin
  if (hh[7] && !mm[7]) begin // 12:00 AM
    pm <= 0;
  end else if (hh[7] || mm[7]) begin // 12:00 PM or after
    pm <= 1;
  end
end

// VERILOG-EVAL: endmodule not found

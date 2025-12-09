

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
    hh <= 4'b0100; // Reset to 12:00 AM
    mm <= 8'b0000_0000;
    ss <= 8'b0000_0000;
    pm <= 1'b0; // AM by default
  end else if (ena) begin
    // Increment seconds counter
    ss <= ss + 1;

    // If seconds rollover, increment minutes and reset seconds to 0
    if (ss[7]) begin
      mm <= mm + 1;
      ss <= 8'b0000_0000;
    end

    // If minutes rollover, increment hours and reset minutes to 0
    if (mm[7]) begin
      hh <= hh + 1;
      mm <= 8'b0000_0000;

      // AM to PM transition at 12:00
      if (hh == 4'b1100) begin
        pm <= ~pm;
        hh <= 4'b0100; // Reset hours to 12
      end
    end
  end
end

// VERILOG-EVAL: endmodule not found


module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  // Timescale declaration moved outside the module
`timescale 1ns / 1ps

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      hh <= 8'b00000010;  // 2 in BCD (for hours, since we need to represent up to 12)
      mm <= 8'b00000000;
      ss <= 8'b00000000;
      pm <= 0;
    end else if (ena) begin
      // Seconds counter
      if (ss == 8'b11001111) {  // 59 in decimal
        ss <= 8'b00000000;
        mm <= mm + 1;
      } else {
        ss <= ss + 1;
      }
      
      // Minutes counter
      if (mm == 8'b11001111) {  // 59 in decimal
        mm <= 8'b00000000;
        hh <= hh + 1;
      } else {
        mm <= mm + 1;
      }
      
      // Hours counter with AM/PM toggle
      if (hh == 8'b00000010 || hh == 8'b0000

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found

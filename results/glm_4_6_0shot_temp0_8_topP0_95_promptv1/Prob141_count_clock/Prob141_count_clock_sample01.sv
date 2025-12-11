
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  // Internal signals for BCD digit separation
  wire [3:0] ss_tens = ss[7:4];
  wire [3:0] ss_units = ss[3:0];
  wire [3:0] mm_tens = mm[7:4];
  wire [3:0] mm_units = mm[3:0];
  wire [3:0] hh_tens = hh[7:4];
  wire [3:0] hh_units = hh[3:0];
  
  // Flags for carry generation
  wire sec_carry;
  wire min_carry;
  wire hour_carry;
  
  // Detect when to increment next counter
  assign sec_carry = (ss == 8'h59);
  assign min_carry = (mm == 8'h59) && sec_carry;
  assign hour_carry = (hh == 8'h12) && min_carry;
  
  // Sequential logic for clock counters
  always @(posedge clk) begin
    if (reset) begin
      // Reset to 12:00:00 AM
      ss <= 8'h00;
      mm <= 8'h00;
      hh <= 8'h12;
      pm <= 1'b0;
    end else if (ena) begin
      // Seconds counter (00-59 in BCD)
      if (ss_units == 4'h9) begin
        if (ss_tens == 4'h5) begin
          ss <= 8'h00;  // Roll over from 59 to 00
        end else begin
          ss[3:0] <= 4'h0;
          ss[7:4] <= ss_tens + 1'b1;
        end
      end else begin
        ss[3:0] <= ss_units + 1'b1;
      end
      
      // Minutes counter (00-59 in BCD), increments when seconds roll over
      if (sec_carry) begin
        if (mm_units == 4'h9) begin
          if (mm_tens == 4'h5) begin
            mm <= 8'h00;  // Roll over from 59 to 00
          end else begin
            mm[3:0] <= 4'h0;
            mm[7:4] <= mm_tens + 1'b1;
          end
        end else begin
          mm[3:0] <= mm_units + 1'b

// VERILOG-EVAL: endmodule not found

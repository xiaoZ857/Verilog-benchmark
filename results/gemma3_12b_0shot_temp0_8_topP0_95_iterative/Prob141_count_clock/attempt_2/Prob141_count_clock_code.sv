
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
  // Internal signals
  reg [7:0] sec_count;
  reg [7:0] min_count;
  reg [7:0] hr_count;

  // Constants for BCD values
  localparam SEC_MAX = 59;
  localparam MIN_MAX = 59;
  localparam HR_MAX = 12;

  always @(posedge clk) begin
    if (reset) begin
      // Reset to 12:00 AM
      sec_count <= 0;
      min_count <= 0;
      hr_count <= HR_MAX;
      pm <= 0; // AM
      hh <= HR_MAX;
      mm <= 0;
      ss <= 0;
    end else if (ena) begin
      // Increment the counters
      if (sec_count == SEC_MAX) begin
        sec_count <= 0;
        if (min_count == MIN_MAX) begin
          min_count <= 0;
          if (hr_count == HR_MAX) begin
            hr_count <= 0;
            pm <= ~pm; // Toggle AM/PM
          end else begin
            hr_count <= hr_count + 1;
          end
        end else begin
          min_count <= min_count + 1;
        end
      end else begin
        sec_count <= sec_count + 1;
      end

      // Assign BCD values to output signals
      hh <= hr_count;
      mm <= min_count;
      ss <= sec_count;
    end
  end

endmodule


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
  localparam SEC_MAX = 8进制的59;  // 0x39
  localparam MIN_MAX = 8进制的59;  // 0x39
  localparam HR_MAX = 8进制的12;  // 0x0C

  always @(posedge clk) begin
    if (reset) begin
      // Reset to 12:00 AM
      sec_count <= SEC_MAX;
      min_count <= MIN_MAX;
      hr_count <= HR_MAX;
      pm <= 0; // AM
      hh <= HR_MAX;
      mm <= MIN_MAX;
      ss <= SEC_MAX;
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

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition

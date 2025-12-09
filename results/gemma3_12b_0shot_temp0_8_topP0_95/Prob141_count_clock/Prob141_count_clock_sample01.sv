
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  // Internal registers for hour, minute, and second
  reg [3:0] hour_reg;
  reg [3:0] minute_reg;
  reg [3:0] second_reg;

  // Always block for reset
  always @(posedge clk) begin
    if (reset) begin
      hour_reg <= 4'b0011; // 0x3 = 3 (representing 12 in BCD)
      minute_reg <= 4'b0000; // 0x0 = 0
      second_reg <= 4'b0000; // 0x0 = 0
      pm <= 0;
    end else begin
      // Increment second
      if (ena) begin
        if (second_reg == 4'b1111) begin // 59
          second_reg <= 4'b0000;
          // Increment minute
          if (minute_reg == 4'b1111) begin // 59
            minute_reg <= 4'b0000;
            // Increment hour
            if (hour_reg == 4'b1011) begin // 11
              hour_reg <= 4'b0100; // 4 (representing 12 in BCD)
              pm <= ~pm; // Toggle PM indicator
            end else begin
              hour_reg <= hour_reg + 1;
            end
          end
        end else begin
          second_reg <= second_reg + 1;
        end
      end
    end
  end

  // Assign BCD outputs
  assign hh = hour_reg;
  assign mm = minute_reg;
  assign ss = second_reg;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

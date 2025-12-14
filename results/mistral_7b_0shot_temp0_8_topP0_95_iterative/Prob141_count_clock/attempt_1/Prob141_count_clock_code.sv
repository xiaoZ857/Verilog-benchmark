
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

reg [3:0] hour_bcd, minute_bcd, second_bcd; // BCD representations of hours, minutes and seconds
reg pm_flag;

always @(posedge clk) begin
    if (reset) begin // Reset condition
        hh <= 12'b0000;
        mm <= 12'b0000;
        ss <= 12'b0000;
        pm_flag <= 1'b0;
    end else if (ena) begin // Clock and Enable condition
        if (mm == 12'd59) begin // If minutes reach 59, increment seconds
            ss <= ss + 1;
            if (ss == 12'd60) begin // If seconds reach 60, reset to zero and increment minutes
                ss <= 12'd0;
                if (mm == 12'd59) begin // If minutes reach 59 when seconds are zero, increment hours
                    hour_bcd <= hour_bcd + 1;
                    if (hour_bcd > 16) begin // Check if hours have overflowed (13 => reset to 1)
                        pm_flag ^= 1; // Toggle AM/PM indicator
                        hour_bcd <= 4'b0001; // Reset hours to 1
                    end
                end
                mm <= mm + 1; // Increment minutes
            end
        end else begin // Otherwise, increment minutes
            mm <= mm + 1;
        end
    end
end

always @(posedge clk) begin // Convert BCD to 7-segment display format
    assign pm = pm_flag;
    always_comb begin
        hh[0] = hour_bcd[3];
        hh[1] = hour_bcd[2];
        hh[2] = hour_bcd[1];
        hh[3] = hour_bcd[0];
        hh[4] = (hour_bcd[3]+hour_bcd[2]+hour_bcd[1]+hour_bcd[0]) >= 10 ? 1'b1 : 1'b0;
        mm[0] = minute_bcd[3];
        mm[1] = minute_bcd[2];
        mm[2] = minute_bcd[1];
        mm[3] = minute_bcd[0];
        mm[4] = (minute_bcd[3]+minute_bcd[2]+minute_bcd[1]+minute_bcd[0]) >= 10 ? 1'b1 : 1'b0;
        ss[0] = second_bcd[3];
        ss[1] = second_bcd[2];
        ss[2] = second_bcd[1];
        ss[3] = second_bcd[0];
        ss[4] = (second_bcd[3]+second_bcd[2]+second_bcd[1]+second_bcd[0]) >= 10 ? 1'b1 : 1'b0;
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found

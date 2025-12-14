
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
        // Synchronous reset to "12:00 AM"
        sec_low <= 4'b0000;
        sec_high <= 4'b0000;
        min_low <= 4'b0000;
        min_high <= 4'b0000;
        hour_low <= 4'b0100; // BCD for '0'
        hour_high <= 4'b0011; // BCD for '12' high part
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
                        if ((hour_low == 4'd9 && hour_high == 4'b0011) || 
                            (hour_low == 4'd0 && hour_high == 4'b0100)) begin
                            hour_low <= 4'b0000;
                            if (hour_high == 4'b0011) begin
                                hour_high <= 4'b0001; // 12 to 01
                                pm <= ~pm; // Toggle AM/PM
                            end else if (hour_high == 4'b0100 && pm == 1'b1) begin
                                hour_high <= 4'b0011; // 12 back to 11 for PM
                                pm <= ~pm; // Toggle AM/PM
                            end else begin
                                hour_high <= hour_high + 1;
                            end
                        end else {
                            hour_low <= hour_low + 1;
                        }
                    end else {
                        min_high <= min_high + 1;
                    }
                end else {
                    min_low <= min_low + 1;
                }
            end else {
                sec_high <= sec_high + 1;
            }
        end else {
            sec_low <= sec_low + 1;
        }
    end
end

// Update BCD outputs
always @(*) begin
    hh = {hour_high, hour_low};
    mm = {min_high, min_low};
    ss = {sec_high, sec_low};
end

endmodule

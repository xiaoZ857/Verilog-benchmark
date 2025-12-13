
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
        // Reset the time to "12:00 AM"
        sec_tens <= 4'b0000;
        sec_ones <= 4'b0000;
        min_tens <= 4'b0000;
        min_ones <= 4'b0000;
        hour_tens <= 3'b000; // '1' for tens place in hours
        hour_ones <= 4'b0010; // '2' for ones place in hours
        pm <= 1'b0;
    end else if (ena) begin
        // Increment seconds
        if (sec_ones == 4'd9) begin
            sec_ones <= 4'b0000;
            if (sec_tens == 4'd5) begin
                sec_tens <= 4'b0000;
                // Increment minutes
                if (min_ones == 4'd9) begin
                    min_ones <= 4'b0000;
                    if (min_tens == 4'd5) begin
                        min_tens <= 4'b0000;
                        // Increment hours
                        if ((hour_ones == 4'd2 && hour_tens == 3'b001) || 
                            (hour_ones == 4'd1 && hour_tens == 3'b000)) {
                            hour_ones <= 4'b0001; // Reset to '01'
                            hour_tens <= 3'b000;
                            pm <= ~pm; // Toggle AM/PM
                        } else if (hour_ones == 4'd9) begin
                            hour_ones <= 4'b0010; // Reset to '10'
                            if (hour_tens == 3'b000) begin
                                hour_tens <= 3'b001;
                            end else if (hour_tens == 3'b001) begin
                                hour_tens <= 3'b000;
                                pm <= ~pm; // Toggle AM/PM
                            end
                        end else {
                            hour_ones <= hour_ones + 1;
                        }
                    end else {
                        min_tens <= min_tens + 1;
                    }
                end else {
                    min_ones <= min_ones + 1;
                }
            end else {
                sec_tens <= sec_tens + 1;
            }
        end else {
            sec_ones <= sec_ones + 1;
        }

        // Convert binary to BCD for output
        hh[7:4] = (hour_tens == 3'b001) ? 4'b0001 : 4'b0000; // Tens place of hours
        hh[3:0] = hour_ones; // Ones place of hours
        mm[7:4] = min_tens;  // Tens place of minutes
        mm[3:0] = min_ones;  // Ones place of minutes
        ss[7:4] = sec_tens;  // Tens place of seconds
        ss[3:0] = sec_ones;  // Ones place of seconds
    end
end

endmodule

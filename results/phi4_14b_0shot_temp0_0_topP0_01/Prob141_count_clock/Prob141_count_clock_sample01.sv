

module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

reg [3:0] sec_tens, sec_ones;
reg [3:0] min_tens, min_ones;
reg [3:0] hour_tens, hour_ones;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    // Reset to "12:00 AM"
    pm <= 1'b0;
    sec_tens <= 4'd0; sec_ones <= 4'd0;
    min_tens <= 4'd0; min_ones <= 4'd0;
    hour_tens <= 4'b0001; hour_ones <= 4'd2;
  end else if (ena) begin
    // Increment seconds
    if (sec_ones == 4'd9) begin
      sec_ones <= 4'd0;
      if (sec_tens == 4'd5) begin
        sec_tens <= 4'd0;
        // Increment minutes
        if (min_ones == 4'd9) begin
          min_ones <= 4'd0;
          if (min_tens == 4'd5) begin
            min_tens <= 4'd0;
            // Increment hours
            if (hour_ones == 4'd2 && hour_tens == 4'b0001) begin
              hour_tens <= 4'b0010; hour_ones <= 4'd0;
            end else if (hour_ones == 4'd9) begin
              hour_ones <= 4'd0;
              if (hour_tens == 4'b0010) begin
                hour_tens <= 4'b0001; hour_ones <= 4'd3;
              end else if (hour_tens == 4'b0001 && hour_ones == 4'd2) begin
                hour_tens <= 4'b0001; hour_ones <= 4'd0;
                pm <= ~pm; // Toggle AM/PM
              end else begin
                hour_tens <= hour_tens + 1'b1;
              end
            end else begin
              hour_ones <= hour_ones + 1'b1;
            end
          end else begin
            hour_ones <= hour_ones + 1'b1;
          end
        end else begin
          min_tens <= min_tens + 1'b1;
        end
      end else begin
        sec_tens <= sec_tens + 1'b1;
      end
    end else begin
      sec_ones <= sec_ones + 1'b1;
    end

    // Update BCD outputs
    hh[7:4] <= hour_tens; hh[3:0] <= hour_ones;
    mm[7:4] <= min_tens; mm[3:0] <= min_ones;
    ss[7:4] <= sec_tens; ss[3:0] <= sec_ones;
  end
end

endmodule

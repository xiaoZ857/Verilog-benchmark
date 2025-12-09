
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  // Internal registers for counting
  reg [3:0] sec_tens;
  reg [3:0] sec_ones;
  reg [3:0] min_tens;
  reg [3:0] min_ones;
  reg [3:0] hour_tens;
  reg [3:0] hour_ones;

  // Synchronize the enable signal
  always @(posedge clk) begin
    if (reset) begin
      sec_tens <= 0;
      sec_ones <= 0;
      min_tens <= 0;
      min_ones <= 0;
      hour_tens <= 1; // For "01"
      hour_ones <= 2;
      pm <= 0;
    end else if (ena) begin
      // Increment seconds
      if (sec_ones == 9) begin
        sec_ones <= 0;
        if (sec_tens == 5) begin
          sec_tens <= 0;
          // Increment minutes
          if (min_ones == 9) begin
            min_ones <= 0;
            if (min_tens == 5) begin
              min_tens <= 0;
              // Increment hours
              if (hour_tens == 1 && hour_ones == 2) begin
                // Transition from 12 to 01
                hour_tens <= 0; 
                hour_ones <= 1;
                pm <= ~pm; // Toggle PM/AM
              end else if (hour_ones == 9) begin
                hour_ones <= 0;
                if (hour_tens == 1) begin
                  hour_tens <= 2; // Transition from 11 to 12
                end else begin
                  hour_tens <= 0; // Transition from 01 to 02, etc.
                end
              end else begin
                hour_ones <= hour_ones + 1;
              end
            end else begin
              min_tens <= min_tens + 1;
            end
          end else begin
            min_ones <= min_ones + 1;
          end
        end else begin
          sec_tens <= sec_tens + 1;
        end
      end else begin
        sec_ones <= sec_ones + 1;
      end
    end
  end

  // Output assignment
  always @(*) begin
    hh = {hour_tens, hour_ones};
    mm = {min_tens, min_ones};
    ss = {sec_tens, sec_ones};
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition



module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);

  reg [7:0] count;
  reg [7:0] seconds_count;
  reg [7:0] minutes_count;
  reg [7:0] hours_count;

  always @(posedge clk) begin
    if (reset) begin
      count <= 0;
      seconds_count <= 0;
      minutes_count <= 0;
      hours_count <= 0;
      pm <= 0;
      hh <= 0;
      mm <= 0;
      ss <= 0;
    end else begin
      if (ena) begin
        count <= count + 1;
        if (count == 60) begin
          count <= 0;
          seconds_count <= seconds_count + 1;
          if (seconds_count == 60) begin
            seconds_count <= 0;
            minutes_count <= minutes_count + 1;
            if (minutes_count == 60) begin
              minutes_count <= 0;
              hours_count <= hours_count + 1;
              if (hours_count == 13) begin
                hours_count <= 1;
                pm <= ~pm;
              end
            end
          end
        end

        if (pm) begin
          hh <= hours_count;
        end else begin
          hh <= hours_count;
        end

        mm <= minutes_count;
        ss <= seconds_count;
      end
    end
  end
endmodule

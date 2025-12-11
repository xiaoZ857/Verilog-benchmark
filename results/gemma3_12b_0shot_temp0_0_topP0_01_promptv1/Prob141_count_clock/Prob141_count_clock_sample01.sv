
module TopModule (
  input clk,
  input reset,
  input ena,
  output reg pm,
  output reg [7:0] hh,
  output reg [7:0] mm,
  output reg [7:0] ss
);
always @(posedge clk) begin
  if (reset) begin
    hh <= 8'b00000012;
    mm <= 8'b00000000;
    ss <= 8'b00000000;
    pm <= 1'b0;
  end else if (ena) begin
    ss <= ss + 1;
    if (ss == 60) begin
      ss <= 0;
      mm <= mm + 1;
      if (mm == 60) begin
        mm <= 0;
        hh <= hh + 1;
        if (hh == 13) begin
          hh <= 1;
        end
      end
    end

    if (hh >= 12) begin
      pm <= 1'b1;
    end else begin
      pm <= 1'b0;
    end
  end
endmodule


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
        pm <= 1'b0;
        hh <= 8'h12;
        mm <= 8'h00;
        ss <= 8'h00;
    end
    else if (ena) begin
        // seconds counter
        if (ss[3:0] == 4'd9) begin
            ss[3:0] <= 4'd0;
            if (ss[7:4] == 4'd5) begin
                ss[7:4] <= 4'd0;
                // minutes counter
                if (mm[3:0] == 4'd9) begin
                    mm[3:0] <= 4'd0;
                    if (mm[7:4] == 4'd5) begin
                        mm[7:4] <= 4'd0;
                        // hours counter
                        if (hh == 8'h12) begin
                            hh <= 8'h01;
                        end
                        else if (hh[3:0] == 4'd9) begin
                            hh[3:0] <= 4'd0;
                            hh[7:4] <= hh[7:4] + 1'b1;
                        end
                        else begin
                            if (hh == 8'h09) begin
                                hh <= 8'h10;
                            end
                            else if (hh == 8'h11) begin
                                hh <= 8'h12;
                                pm <= ~pm;
                            end
                            else begin
                                hh[3:0] <= hh[3:0] + 1'b1;
                            end
                        end
                    end
                    else begin
                        mm[7:4] <= mm[7:4] + 1'b1;
                    end
                end
                else begin
                    mm[3:0] <= mm[3:0] + 1'b1;
                end
            end
            else begin
                ss[7:4] <= ss[7:4] + 1'b1;
            end
        end
        else begin
            ss[3:0] <= ss[3:0] + 1'b1;
        end
    end
end
endmodule

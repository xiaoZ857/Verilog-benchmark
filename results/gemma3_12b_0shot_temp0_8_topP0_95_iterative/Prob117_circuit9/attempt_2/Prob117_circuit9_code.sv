
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
  always @(posedge clk) begin
    if (a == 1) begin
      case (q)
        3'000: q <= 1;
        3'001: q <= 4;
        3'010: q <= 4;
        3'011: q <= 4;
        3'100: q <= 4;
        3'101: q <= 4;
        3'110: q <= 6;
        3'111: q <= 6;
        default: q <= 4;
      endcase
    end else begin
      case (q)
        3'000: q <= 0;
        3'001: q <= 4;
        3'010: q <= 4;
        3'011: q <= 4;
        3'100: q <= 4;
        3'101: q <= 4;
        3'110: q <= 6;
        3'111: q <= 6;
        default: q <= 4;
      endcase
    end
  end

// VERILOG-EVAL: endmodule not found

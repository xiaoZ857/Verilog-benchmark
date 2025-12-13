
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
always @(posedge clk) begin
  case(scancode)
    16'h06b : left <= 1;
    16'h072 : down <= 1;
    16'h074 : right <= 1;
    16'h075 : up <= 1;
    default : begin
      left <= 0;
      down <= 0;
      right <= 0;
      up <= 0;
    end
  endcase
end

// Assuming clk is an external clock signal
// You may need to adjust the always block depending on your design's clocking scheme

endmodule

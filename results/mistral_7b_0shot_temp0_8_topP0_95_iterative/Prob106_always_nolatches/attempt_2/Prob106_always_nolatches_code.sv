
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
always @(posedge clk) begin
    case (scancode)
        16'b06b : left <= 1;
        16'b072 : down <= 1;
        16'b074 : right <= 1;
        16'b075 : up <= 1;
        default : begin
            left <= 0;
            down <= 0;
            right <= 0;
            up <= 0;
        end
    endcase
end

// Assuming clk is an external positive clock signal

endmodule

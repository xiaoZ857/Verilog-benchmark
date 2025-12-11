
module TopModule (
  input [15:0] scancode,
  output reg left,
  output reg down,
  output reg right,
  output reg up
);
assign left = (scancode == 16#0x06B) || (scancode == 16#0x072);
assign down = (scancode == 16#0x074) || (scancode == 16#0x075);
always @(posedge clk)
    begin
        right <= !!(scancode == 16#0x06B) && !(scancode == 16#0x072) && 
                !(scancode == 16#0x074) && !(scancode == 16#0x075);
        up <= !(scancode == 16#0x06B) && !(scancode == 16#0x072) &&
              !(scancode == 16#0x074) && !(scancode == 16#0x075);
    end
endmodule

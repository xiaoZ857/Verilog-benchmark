
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
  reg [7:0] q;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 8'b00110100;  // Reset to 0x34
    end else begin
      q <= d;
    end
  end

  always @(negedge clk) begin
    if (reset) begin
      q <= 8'b00110100;
    end else begin
      q <= d;
    end
  end
endmodule

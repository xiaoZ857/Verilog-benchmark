
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
  reg [3:0] count;

  always @(posedge clk) begin
    if (reset) begin
      count <= 1;
    end else begin
      if (count == 10) begin
        count <= 1;
      end else begin
        count <= count + 1;
      end
    end
  end

  assign q = count;
endmodule

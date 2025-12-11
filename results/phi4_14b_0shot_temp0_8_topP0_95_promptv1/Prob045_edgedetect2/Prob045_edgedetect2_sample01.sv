
module TopModule (
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);
  reg [7:0] in_reg;

  always @(posedge clk) begin
    anyedge <= ^in ^ in_reg; // XOR to detect changes
    in_reg <= in;
  end

endmodule

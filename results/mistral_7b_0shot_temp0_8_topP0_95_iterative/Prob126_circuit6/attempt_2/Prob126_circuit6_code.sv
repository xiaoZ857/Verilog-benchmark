
module TopModule (
  input [2:0] a,
  output reg [15:0] q
);
reg [15:0] hex_values = 3'b000, 3'b001, 3'b010, 3'b011,
            3'b100, 3'b101, 3'b110, 3'b111;

always @(posedge clk) begin
  case(a)
    0 : q <= 16'h1232;
    1 : q <= 16'hAEEE; // Hexadecimal 'A' is 10 in decimal.
    2 : q <= 16'h27D4;
    3 : q <= 16'h5A0E;
    4 : q <= 16'h2066;
    5 : q <= 16'h64CE;
    6 : q <= 16'hC526;
    7 : q <= 16'h2F19;
    default: q <= 16'h1232; // For the missing a=0 case at time 55ns and beyond
  endcase
end

endmodule

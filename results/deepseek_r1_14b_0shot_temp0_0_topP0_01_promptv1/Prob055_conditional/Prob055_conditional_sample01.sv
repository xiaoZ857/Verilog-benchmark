
module TopModule (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);
always @* begin
    logic [7:0] min_ab, min_abc, min_final;
    min_ab = (a < b) ? a : b;
    min_abc = (min_ab < c) ? min_ab : c;
    min_final = (min_abc < d) ? min_abc : d;
    min = min_final;
end
endmodule


module TopModule (
  input [2:0] a,
  output reg [15:0] q
);
assign q = {a[1], a[2], (a[0] == 3'b000) ? 1232 : (a[0] == 3'b001) ? aee0 : (a[0] == 3'b010) ? 27d4 : (a[0] == 3'b011) ? 5a0e : (a[0] == 3'b100) ? 2066 : (a[0] == 3'b101) ? 64ce : (a[0] == 3'b110) ? c526 : (a[0] == 3'b111) ? 2f19 : 0}; endmodule

// VERILOG-EVAL: endmodule not found

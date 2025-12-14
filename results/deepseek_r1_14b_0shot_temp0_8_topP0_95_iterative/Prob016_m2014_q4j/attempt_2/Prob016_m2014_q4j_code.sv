
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
  
wire c;
assign {c, sum[0]} = x + y;
assign sum[1] = (x ^ y) & ~c;
assign sum[2] = (~x | ~y) & c;
wire overflow = c & (~x[3] ^ ~y[3]);
assign sum[4] = overflow;

endmodule

// VERILOG-EVAL: errant inclusion of module definition

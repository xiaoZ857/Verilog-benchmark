
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);
// FullAdder module
module FullAdder (
  input a, b, cin,
  output reg sum,
  output reg cout
);

always @(posedge clk) begin
  if((a + b + cin) > 3'b11) begin
    sum <= 4'b0;
    cout <= 1'b1;
  end else begin
    sum <= a + b + cin;
    cout <= 1'b0;
  end
end

endmodule

// TopModule implementation
module TopModule (
  input [3:0] x,
  input [3:0] y,
  output reg [4:0] sum,
  output reg overflow
);

wire [3:0] cin;
FullAdder fa0 (x[0], y[0], cin[3], sum[0]);
FullAdder fa1 (x[1], y[1], cin[2], sum[1]);
FullAdder fa2 (x[2], y[2], cin[1], sum[2]);
FullAdder fa3 (x[3], y[3], cin[0], sum[3], overflow);

assign cin = sum[3]; // Carry-out of the last full adder feeds back to carry-in of the first full adder

endmodule

// VERILOG-EVAL: errant inclusion of module definition

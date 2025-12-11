
module TopModule (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);
 ```verilog
always @* begin
    assign q = (a & b) + ((c << 4) | d) * (e >> 1);
end
endmodule

// VERILOG-EVAL: abnormal backticks count

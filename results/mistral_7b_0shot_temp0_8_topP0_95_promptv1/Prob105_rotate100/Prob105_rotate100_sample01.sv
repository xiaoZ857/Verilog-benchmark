
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
 ```verilog
always @(posedge clk) begin
    if (load)
        q <= data;
    else if (ena[1])
        assign q[0] = q[99];
    else if (ena[0])
        assign q[99] = q[0];
    else
        // no rotation
        ;
end
assign out = q;
endmodule

// VERILOG-EVAL: abnormal backticks count

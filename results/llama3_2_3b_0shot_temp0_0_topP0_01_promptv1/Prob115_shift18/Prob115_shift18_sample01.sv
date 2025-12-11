
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
assign q = (load || ena) ? data : q[63:0][amount[1:0]]'d0;
always @(posedge clk) begin
    if (ena)
        q <= {q[62:0], data[63]};
    else if (load)
        q <= data;
endmodule

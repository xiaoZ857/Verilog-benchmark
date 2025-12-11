
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);
assign q = {data[99], data[98:0]};
assign q[99] = data[100];
assign q[100] = data[98];

always @(posedge clk) begin
    if (load)
        q <= data;
    else if (ena == 2'b01)
        q <= {q[99], q};
    else if (ena == 2'b10)
        q <= {q, q[0:98]};
    end

endmodule


module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
assign q = {data[3], data[2], data[1], data[0]};
assign q[0] = data[3];
assign q[1] = data[2];
assign q[2] = data[1];
assign q[3] = data[0];

always @(posedge clk or posedge areset) begin
    if (areset)
        q <= 4'b0000;
    else if (load && ena)
        q <= data;
    else if (ena)
        q <= {q[2], q[1], q[0]};
end

endmodule
